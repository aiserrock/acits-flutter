/// Public pages the stores require the app to link to.
///
/// Set the final addresses before the first release (see `doc/release.md`,
/// "Legal pages and account deletion"). The same URLs go into the store
/// listings: Google Play and App Store reject an app whose in-app links and
/// listing links differ or do not open.
abstract final class LegalLinks {
  /// Privacy policy (also linked from the registration consent).
  static final privacyPolicy = Uri.parse('https://app.acits.ru/privacy-policy');

  /// Terms of use.
  static final terms = Uri.parse('https://app.acits.ru/terms');

  /// Public page that explains how to delete an account and its data. Google Play
  /// asks for it in the Data safety form, separately from the in-app flow.
  static final accountDeletion = Uri.parse('https://app.acits.ru/account-deletion');

  /// Support mailbox for feedback and for account deletion requests.
  static const supportEmail = 'support@acits.ru';
}
