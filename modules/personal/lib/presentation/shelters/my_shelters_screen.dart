import 'package:core/domain.dart' show Shelter;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:util/util.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/presentation/shelters/my_shelters_cubit.dart';

/// «My organisations»: the shelters the user belongs to, the current one marked.
///
/// Read-only. A tap on another shelter is reported through [onSwitch]; the host
/// app performs the switch.
class MySheltersScreen extends StatelessWidget {
  const MySheltersScreen({required this.source, required this.onSwitch, super.key});

  final MySheltersSource source;
  final ValueChanged<Shelter> onSwitch;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MySheltersCubit(source)..load(),
      child: _MySheltersView(onSwitch: onSwitch),
    );
  }
}

class _MySheltersView extends StatelessWidget {
  const _MySheltersView({required this.onSwitch});

  final ValueChanged<Shelter> onSwitch;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MySheltersCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.of(context).maybePop(),
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(LocaleKeys.personMyShelters.tr(), style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        centerTitle: true,
      ),
      body: ContentWidth(
        maxWidth: ContentWidth.reading,
        child: BlocBuilder<MySheltersCubit, DataState<List<Shelter>>>(
          builder: (context, state) => DataStateBuilder<List<Shelter>>(
            state: state,
            loader: (_) => const LoaderHolderWidget(),
            errorBuilder: (_, failure) => ErrorHolderWidget(error: failure, onPressed: cubit.load),
            builder: (_, shelters) => RefreshIndicator(
              onRefresh: cubit.refresh,
              child: shelters.isEmpty ? const _EmptyView() : _ShelterList(shelters, cubit.currentShelterId, onSwitch),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShelterList extends StatelessWidget {
  const _ShelterList(this.shelters, this.currentId, this.onSwitch);

  final List<Shelter> shelters;
  final int? currentId;
  final ValueChanged<Shelter> onSwitch;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: shelters.length,
      separatorBuilder: (_, _) => const Divider(indent: 16.0, endIndent: 16.0, height: 1.0),
      itemBuilder: (context, index) {
        final shelter = shelters[index];
        final isCurrent = shelter.id == currentId;
        return ListTile(
          title: Text(shelter.name),
          selected: isCurrent,
          trailing: isCurrent ? Icon(Icons.check, semanticLabel: LocaleKeys.personMySheltersCurrent.tr()) : null,
          onTap: isCurrent ? null : () => onSwitch(shelter),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    // Scrollable so pull-to-refresh also works on an empty list.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24.0),
      children: [
        Text(
          LocaleKeys.personMySheltersEmpty.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
