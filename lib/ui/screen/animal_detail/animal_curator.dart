part of 'animal_detail_screen.dart';

SliverList _buildCuratorPage(BuildContext context, AnimalRead animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildCuratorContent(context, animal)));
}

List<Widget> _buildCuratorContent(BuildContext context, AnimalRead animal) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(
        LocaleKeys.animalCurator.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalCuratorName.tr(), firstValue: animal.curatorFullName),
      CardData(firstCaption: LocaleKeys.animalCuratorPhone.tr(), firstValue: animal.curatorPhone),
      CardData(firstCaption: LocaleKeys.animalCuratorEmail.tr(), firstValue: animal.curatorEmail),
      CardData(
        firstCaption: LocaleKeys.animalCuratorAddress.tr(),
        firstValue: animal.curatorAddress,
      ),
    ], valueStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.0)),
    const SizedBox(height: 64.0),
  ];
}
