part of 'animal_detail_screen.dart';

SliverList _buildPrescriptionsPage(
  WidgetState<List<Prescription?>?> state,
  BehaviorSubject<_PrescriptionState> switchState,
  VoidCallback onReload,
) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            left: 16.0,
            bottom: 8.0,
          ),
          child: StreamBuilder<_PrescriptionState>(
              stream: switchState,
              builder: (_, snapshot) {
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringRes.current.animalPrescriptions,
                        style: StyleRes.title.copyWith(fontSize: 22.0),
                      ),
                    ),
                    Text(snapshot.data == _PrescriptionState.active ? 'Current' : 'Past'),
                    Switch(
                      value: snapshot.data == _PrescriptionState.active,
                      onChanged: (state) => switchState.add(
                        state ? _PrescriptionState.active : _PrescriptionState.inactive,
                      ),
                      activeColor: ColorRes.accent,
                    )
                  ],
                );
              }),
        ),
        if (state.isContent)
          ...state.value!
              .where((element) => element != null)
              .map<Widget>((item) => AnimalPrescriptionCard(prescription: item!)),
        if (state.isLoading) const LoaderHolderWidget(),
        if (state.hasError) ErrorHolderWidget(onPressed: onReload),
        const SizedBox(height: 64.0),
      ],
    ),
  );
}

enum _PrescriptionState {
  active,
  inactive,
}
