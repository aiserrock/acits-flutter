part of 'animal_detail_screen.dart';

SliverList _buildApplicantPage(Animal animal) {
  return SliverList(
    delegate: SliverChildListDelegate(
      _buildApplicantContent(animal),
    ),
  );
}

List<Widget> _buildApplicantContent(Animal animal) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        StringRes.current.animalApplicant,
        style: StyleRes.title.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard(
      [
        CardData(
          firstCaption: StringRes.current.animalCuratorName,
          firstValue: animal.applicantFullName,
        ),
        CardData(
          firstCaption: StringRes.current.animalCuratorPhone,
          firstValue: animal.applicantPhone,
        ),
        CardData(
          firstCaption: StringRes.current.animalCuratorEmail,
          firstValue: animal.applicantEmail,
        ),
        CardData(
          firstCaption: StringRes.current.animalSocialLink,
          firstValue: null,
        ),
        CardData(
          firstCaption: StringRes.current.animalTransferAct,
          firstValue: null,
        ),
      ],
      valueStyle: StyleRes.mainContent.copyWith(fontSize: 16.0),
    ),
    const SizedBox(height: 64.0),
  ];
}
