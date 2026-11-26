import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart' show ContentWidth, PrimaryButton;
import 'package:util/util.dart' show Failure, NoInternet, ServerFailure, Timeout;

import 'package:auth/domain/domain.dart';

/// The parts of a password reset link the server needs back:
/// `https://<host>/api/v1/users/reset-password/confirm/<uidb64>/<token>/`.
class PasswordResetLink {
  const PasswordResetLink({required this.uidb64, required this.token});

  final String uidb64;
  final String token;

  static const _marker = 'reset-password/confirm';

  /// Parses [link]; `null` when it is not a reset link. Only https links on
  /// `acits.ru` or its subdomains are accepted: the token is a credential.
  static PasswordResetLink? tryParse(String link) {
    final uri = Uri.tryParse(link);
    if (uri == null || uri.scheme != 'https') return null;
    if (uri.host != 'acits.ru' && !uri.host.endsWith('.acits.ru')) return null;
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    final at = segments.indexWhere((s) => s == 'confirm');
    if (at < 1 || segments[at - 1] != 'reset-password' || segments.length < at + 3) return null;
    final uidb64 = segments[at + 1];
    final token = segments[at + 2];
    if (uidb64.isEmpty || token.isEmpty) return null;
    return PasswordResetLink(uidb64: uidb64, token: token);
  }

  /// Whether [path] looks like a reset link path (for the deep link router).
  static bool matchesPath(String path) => path.contains(_marker);
}

/// Minimum length the screen asks for. The server applies its own rules too.
const kMinPasswordLength = 8;

/// Sets a new password from a reset link opened in the app.
class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({required this.auth, required this.link, required this.onDone, super.key});

  final AuthSessionApi auth;

  /// The raw link from the e-mail.
  final String link;

  /// Leave the screen after success (normally: go to the sign-in screen).
  final VoidCallback onDone;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  late final PasswordResetLink? _link = PasswordResetLink.tryParse(widget.link);
  final _password = TextEditingController();
  final _repeat = TextEditingController();
  bool _saving = false;
  bool _done = false;
  String? _passwordError;
  String? _repeatError;
  String? _requestError;

  @override
  void dispose() {
    _password.dispose();
    _repeat.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final link = _link;
    if (link == null) return;
    final password = _password.text;
    setState(() {
      _passwordError = password.length < kMinPasswordLength ? LocaleKeys.resetPassTooShort.tr() : null;
      _repeatError = _repeat.text != password ? LocaleKeys.resetPassMismatch.tr() : null;
      _requestError = null;
    });
    if (_passwordError != null || _repeatError != null) return;

    setState(() => _saving = true);
    final result = await widget.auth.completePasswordReset(
      uidb64: link.uidb64,
      token: link.token,
      newPassword: password,
    );
    if (!mounted) return;
    final failure = result.failureOrNull;
    setState(() {
      _saving = false;
      if (failure == null) {
        _done = true;
      } else {
        _requestError = _messageFor(failure);
      }
    });
  }

  String _messageFor(Failure failure) => switch (failure) {
    NoInternet() => LocaleKeys.errorInternetFailMsg.tr(),
    Timeout() => LocaleKeys.errorTimeoutFailMsg.tr(),
    // 400 here means the token is wrong or expired, or the password is rejected;
    // the server explains which in the body when it can.
    ServerFailure(:final code, :final note) when code == 400 =>
      (note?.isNotEmpty ?? false) ? note! : LocaleKeys.resetPassLinkInvalid.tr(),
    ServerFailure(:final code) when code >= 500 => LocaleKeys.errorServerFailMsg.tr(),
    _ => LocaleKeys.errorDefaultMsg.tr(),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.resetPassNewTitle.tr())),
      body: SafeArea(
        child: ContentWidth(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_link == null) ...[
                  Text(LocaleKeys.resetPassLinkInvalid.tr(), style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24.0),
                  PrimaryButton(onPressed: widget.onDone, text: LocaleKeys.commonBack.tr()),
                ] else if (_done) ...[
                  Text(LocaleKeys.resetPassDone.tr(), style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24.0),
                  PrimaryButton(onPressed: widget.onDone, text: LocaleKeys.loginEntryBtn.tr()),
                ] else ...[
                  Text(LocaleKeys.resetPassNewMsg.tr(), style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 16.0),
                  TextField(
                    key: const Key('newPassword'),
                    controller: _password,
                    obscureText: true,
                    enabled: !_saving,
                    autofillHints: const [AutofillHints.newPassword],
                    decoration: InputDecoration(
                      labelText: LocaleKeys.personalNewPass.tr().trim(),
                      errorText: _passwordError,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    key: const Key('repeatPassword'),
                    controller: _repeat,
                    obscureText: true,
                    enabled: !_saving,
                    autofillHints: const [AutofillHints.newPassword],
                    onSubmitted: (_) => _save(),
                    decoration: InputDecoration(
                      labelText: LocaleKeys.personalRePass.tr().trim(),
                      errorText: _repeatError,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  if (_requestError != null) ...[
                    const SizedBox(height: 12.0),
                    Text(_requestError!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
                  ],
                  const SizedBox(height: 20.0),
                  if (_saving)
                    const Center(child: CircularProgressIndicator())
                  else
                    PrimaryButton(onPressed: _save, text: LocaleKeys.resetPassSave.tr()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
