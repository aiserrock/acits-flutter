import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shell/res/legal_links.dart';

/// Sends an account deletion request.
///
/// Both stores require in-app account deletion when the app has sign-up. The
/// backend has no deletion endpoint yet, so [SupportMailAccountDeletion] files
/// the request with support; an implementation over the endpoint replaces it
/// without touching the UI.
abstract interface class AccountDeletion {
  /// Returns `true` when the request left the device.
  Future<bool> request({required String email, required String shelter});
}

/// Interim [AccountDeletion]: a pre-filled e-mail to support.
class SupportMailAccountDeletion implements AccountDeletion {
  const SupportMailAccountDeletion({Future<bool> Function(Uri)? launch}) : _launch = launch ?? _launchMail;

  final Future<bool> Function(Uri) _launch;

  static Future<bool> _launchMail(Uri uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

  /// The `mailto:` link for the request. Visible for tests.
  static Uri mailFor({required String email, required String shelter}) => Uri(
    scheme: 'mailto',
    path: LegalLinks.supportEmail,
    query: _query({
      'subject': LocaleKeys.accountDeleteMailSubject.tr(),
      // The ids support needs are appended outside the translated text, so they
      // reach support even if a translation drops a placeholder.
      'body': '${LocaleKeys.accountDeleteMailBody.tr(args: [email, shelter])}\n\n---\nemail: $email\nshelter: $shelter',
    }),
  );

  @override
  Future<bool> request({required String email, required String shelter}) async {
    try {
      return await _launch(mailFor(email: email, shelter: shelter));
    } catch (_) {
      return false;
    }
  }
}

/// `Uri(queryParameters:)` encodes spaces as `+`, which mail apps show
/// literally; mailto needs `%20`.
String _query(Map<String, String> params) =>
    params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value)}').join('&');

/// A `mailto:` link to support with [subject].
Uri supportMail({required String subject}) =>
    Uri(scheme: 'mailto', path: LegalLinks.supportEmail, query: _query({'subject': subject}));

/// Asks for confirmation, sends the request and signs out.
///
/// When no mail app can take the request, the public deletion page opens
/// instead, and the user stays signed in.
Future<void> confirmAccountDeletion(
  BuildContext context, {
  required AccountDeletion deletion,
  required String email,
  required String shelter,
  required VoidCallback onRequested,
  Future<bool> Function(Uri)? openPage,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(LocaleKeys.accountDeleteTitle.tr()),
      content: Text(LocaleKeys.accountDeleteMsg.tr()),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(LocaleKeys.commonCancel.tr())),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
          child: Text(LocaleKeys.accountDeleteConfirm.tr()),
        ),
      ],
    ),
  );
  if (confirmed != true) return;

  final sent = await deletion.request(email: email, shelter: shelter);
  if (sent) {
    onRequested();
    return;
  }
  if (!context.mounted) return;
  ScaffoldMessenger.maybeOf(
    context,
  )?.showSnackBar(SnackBar(content: Text(LocaleKeys.accountDeleteNoMail.tr(args: [LegalLinks.supportEmail]))));
  final open = openPage ?? ((uri) => launchUrl(uri, mode: LaunchMode.externalApplication));
  await open(LegalLinks.accountDeletion);
}
