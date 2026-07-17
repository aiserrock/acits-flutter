part of 'animal_detail_screen.dart';

SliverList _buildCuratorPage(BuildContext context, Animal animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildCuratorContent(context, animal)));
}

List<Widget> _buildCuratorContent(BuildContext context, Animal animal) {
  final curator = animal.curator;
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(
        LocaleKeys.animalCurator.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalCuratorName.tr(), firstValue: curator?.fullName),
      CardData(firstCaption: LocaleKeys.animalCuratorPhone.tr(), firstValue: curator?.phoneNumber),
      CardData(firstCaption: LocaleKeys.animalCuratorEmail.tr(), firstValue: curator?.email),
      CardData(firstCaption: LocaleKeys.animalCuratorAddress.tr(), firstValue: curator?.extra),
    ], valueStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.0)),
    const SizedBox(height: 64.0),
  ];
}
