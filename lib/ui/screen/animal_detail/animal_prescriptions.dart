part of 'animal_detail_screen.dart';

SliverList _buildPrescriptionsPage(WidgetState<List<Prescription?>?> state) {
  return state.isContent
      ? SliverList(
          delegate: SliverChildListDelegate(
            _buildPrescriptionsContent(state.value!),
          ),
        )
      : state.isLoading
          ? SliverList(
              delegate: SliverChildListDelegate(
                [Text(StringRes.current.commonLoading)],
              ),
            )
          : SliverList(
              delegate: SliverChildListDelegate(
                [Text(StringRes.current.commonError)],
              ),
            );
}

List<Widget> _buildPrescriptionsContent(List<Prescription?> list) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        StringRes.current.animalPrescriptions,
        style: StyleRes.title.copyWith(fontSize: 22.0),
      ),
    ),
    ...list
        .where((element) => element != null)
        .map<Widget>((item) => AnimalPrescriptionCard(prescription: item!)),
    const SizedBox(height: 64.0),
  ];
}
