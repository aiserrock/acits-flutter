part of 'animal_detail_screen.dart';

SliverList _buildCuratorPage(AnimalRead animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildCuratorContent(animal)));
}

List<Widget> _buildCuratorContent(AnimalRead animal) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(StringRes.current.animalCurator, style: StyleRes.title.copyWith(fontSize: 22.0)),
    ),
    AnimalContentCard([
      CardData(
        firstCaption: StringRes.current.animalCuratorName,
        firstValue: animal.curatorFullName,
      ),
      CardData(firstCaption: StringRes.current.animalCuratorPhone, firstValue: animal.curatorPhone),
      CardData(firstCaption: StringRes.current.animalCuratorEmail, firstValue: animal.curatorEmail),
      CardData(
        firstCaption: StringRes.current.animalCuratorAddress,
        firstValue: animal.curatorAddress,
      ),
    ], valueStyle: StyleRes.mainContent.copyWith(fontSize: 16.0)),
    const SizedBox(height: 64.0),
  ];
}
