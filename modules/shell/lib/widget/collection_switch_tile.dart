import 'package:material_ui/material_ui.dart';
import 'package:observability/observability.dart';

import 'package:shell/src/shell_exports.dart';

/// Переключатель «отправлять статистику и отчёты об ошибках»: управляет сбором
/// в Analytics, Crashlytics и Sentry разом. Включён, пока пользователь не выключит.
class CollectionSwitchTile extends StatefulWidget {
  const CollectionSwitchTile({required this.settings, super.key});

  final CollectionSettings settings;

  @override
  State<CollectionSwitchTile> createState() => _CollectionSwitchTileState();
}

class _CollectionSwitchTileState extends State<CollectionSwitchTile> {
  late bool _enabled = widget.settings.isEnabled;

  Future<void> _onChanged(bool value) async {
    setState(() => _enabled = value);
    await widget.settings.setEnabled(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SwitchListTile(
      value: _enabled,
      onChanged: _onChanged,
      title: Text(LocaleKeys.privacyCollectionTitle.tr(), style: theme.textTheme.bodyLarge),
      subtitle: Text(LocaleKeys.privacyCollectionSubtitle.tr(), style: theme.textTheme.bodySmall),
      activeThumbColor: theme.colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}
