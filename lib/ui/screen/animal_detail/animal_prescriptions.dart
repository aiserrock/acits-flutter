part of 'animal_detail_screen.dart';

extension _AnimalPrescriptionsPage on _AnimalDetailViewState {
  Widget _buildPrescriptionsPage() {
    return BlocBuilder<AnimalDetailCubit, AnimalDetailState>(
      buildWhen: (prev, next) =>
          prev.prescriptions != next.prescriptions ||
          prev.prescriptionActive != next.prescriptionActive,
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      LocaleKeys.animalPrescriptions.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
                    ),
                  ),
                  Text(
                    state.prescriptionActive
                        ? LocaleKeys.prescriptionCurrent.tr()
                        : LocaleKeys.prescriptionPast.tr(),
                  ),
                  Switch(
                    value: state.prescriptionActive,
                    onChanged: _cubit.togglePrescriptionActive,
                    activeThumbColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
            if (state.prescriptions.isContent)
              ...?state.prescriptions.valueOrNull?.map<Widget>(
                (item) => AnimalPrescriptionCard(prescription: item),
              ),
            if (state.prescriptions.isLoading) const LoaderHolderWidget(),
            if (state.prescriptions.hasError)
              ErrorHolderWidget(onPressed: _cubit.reloadPrescriptions),
            const SizedBox(height: 64.0),
          ]),
        );
      },
    );
  }
}
