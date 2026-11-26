import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart' show ContentWidth, PrimaryButton;

import 'package:auth/domain/domain.dart';
import 'package:util/util.dart' show Failure, NoInternet, ServerFailure, Timeout;

/// Loose e-mail check: something@something.something, no spaces. The server
/// decides whether the address exists.
final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

/// Whether [value] looks like an e-mail address. Visible for tests.
bool isPlausibleEmail(String value) => _emailPattern.hasMatch(value.trim());

/// The server answers 400 for an e-mail with no account. The sheet shows the
/// same confirmation as for a known one. Visible for tests.
bool isUnknownAddress(Failure failure) => failure is ServerFailure && failure.code == 400;

/// Opens the password recovery sheet over the login screen.
Future<void> showPasswordResetSheet(BuildContext context, {required AuthSessionApi auth, String initialEmail = ''}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => PasswordResetSheet(auth: auth, initialEmail: initialEmail),
  );
}

/// One field and one button: asks the server to e-mail a reset link.
///
/// The answer is the same whether the address is registered or not (the server
/// answers 400 for an unknown e-mail): telling them apart would let anyone check
/// which addresses have accounts. Network errors are shown as errors.
class PasswordResetSheet extends StatefulWidget {
  const PasswordResetSheet({required this.auth, this.initialEmail = '', super.key});

  final AuthSessionApi auth;
  final String initialEmail;

  @override
  State<PasswordResetSheet> createState() => _PasswordResetSheetState();
}

class _PasswordResetSheetState extends State<PasswordResetSheet> {
  late final _controller = TextEditingController(
    text: isPlausibleEmail(widget.initialEmail) ? widget.initialEmail.trim() : '',
  );
  bool _sending = false;
  bool _sent = false;
  String? _fieldError;
  String? _requestError;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final email = _controller.text.trim();
    if (!isPlausibleEmail(email)) {
      setState(() => _fieldError = LocaleKeys.resetPassInvalidEmail.tr());
      return;
    }
    setState(() {
      _sending = true;
      _fieldError = null;
      _requestError = null;
    });
    final result = await widget.auth.requestPasswordReset(email);
    if (!mounted) return;
    final failure = result.failureOrNull;
    setState(() {
      _sending = false;
      if (failure == null || isUnknownAddress(failure)) {
        _sent = true;
      } else {
        _requestError = _messageFor(failure);
      }
    });
  }

  String _messageFor(Failure failure) => switch (failure) {
    NoInternet() => LocaleKeys.errorInternetFailMsg.tr(),
    Timeout() => LocaleKeys.errorTimeoutFailMsg.tr(),
    ServerFailure(:final code) when code >= 500 => LocaleKeys.errorServerFailMsg.tr(),
    _ => LocaleKeys.errorDefaultMsg.tr(),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: ContentWidth(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(header: true, child: Text(LocaleKeys.resetPassTitle.tr(), style: theme.textTheme.titleLarge)),
              const SizedBox(height: 12.0),
              if (_sent)
                Text(LocaleKeys.resetPassSent.tr(), style: theme.textTheme.bodyLarge)
              else ...[
                Text(LocaleKeys.resetPassMsg.tr(), style: theme.textTheme.bodyMedium),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  enabled: !_sending,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  decoration: InputDecoration(
                    labelText: LocaleKeys.resetPassEmailLabel.tr(),
                    errorText: _fieldError,
                    border: const OutlineInputBorder(),
                  ),
                ),
                if (_requestError != null) ...[
                  const SizedBox(height: 12.0),
                  Text(_requestError!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
                ],
                const SizedBox(height: 20.0),
                if (_sending)
                  const Center(child: CircularProgressIndicator())
                else
                  PrimaryButton(onPressed: _send, text: LocaleKeys.resetPassSend.tr()),
              ],
              if (_sent) ...[
                const SizedBox(height: 20.0),
                PrimaryButton(onPressed: () => Navigator.of(context).pop(), text: LocaleKeys.commonClose.tr()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
