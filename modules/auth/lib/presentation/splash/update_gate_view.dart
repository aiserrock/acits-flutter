import 'package:easy_localization/easy_localization.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart' show ContentWidth, PrimaryButton;

import 'package:auth/domain/app_update_policy.dart';

/// Full-screen notice shown by the splash before any route when this build must
/// (or should) be updated, or when the app is switched off remotely.
class UpdateGateView extends StatelessWidget {
  const UpdateGateView({
    required this.requirement,
    required this.onUpdate,
    this.onLater,
    this.onRetry,
    this.message,
    super.key,
  }) : assert(requirement != UpdateRequirement.none);

  final UpdateRequirement requirement;

  /// Opens the store. Not shown for [UpdateRequirement.blocked].
  final VoidCallback onUpdate;

  /// Continue with this build. Shown only for [UpdateRequirement.recommended].
  final VoidCallback? onLater;

  /// Ask the remote policy again. Shown only for [UpdateRequirement.blocked].
  final VoidCallback? onRetry;

  /// Remote text that replaces the default message.
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (title, body) = switch (requirement) {
      UpdateRequirement.required => (LocaleKeys.updateRequiredTitle.tr(), LocaleKeys.updateRequiredMsg.tr()),
      UpdateRequirement.recommended => (LocaleKeys.updateRecommendedTitle.tr(), LocaleKeys.updateRecommendedMsg.tr()),
      _ => (LocaleKeys.appBlockedTitle.tr(), LocaleKeys.appBlockedMsg.tr()),
    };
    final icon = requirement == UpdateRequirement.blocked ? Icons.cloud_off_outlined : Icons.system_update_outlined;
    final text = (message?.trim().isNotEmpty ?? false) ? message!.trim() : body;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: ContentWidth(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                Icon(icon, size: 72.0, color: theme.colorScheme.primary),
                const SizedBox(height: 24.0),
                Semantics(
                  header: true,
                  child: Text(title, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
                ),
                const SizedBox(height: 12.0),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                const Spacer(),
                if (requirement == UpdateRequirement.blocked)
                  PrimaryButton(onPressed: onRetry ?? () {}, text: LocaleKeys.commonRepeat.tr())
                else
                  PrimaryButton(onPressed: onUpdate, text: LocaleKeys.updateAction.tr()),
                if (requirement == UpdateRequirement.recommended && onLater != null) ...[
                  const SizedBox(height: 8.0),
                  TextButton(onPressed: onLater, child: Text(LocaleKeys.updateLater.tr())),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
