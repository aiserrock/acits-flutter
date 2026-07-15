part of 'animal_detail_screen.dart';

SliverList _buildApplicantPage(BuildContext context, AnimalRead animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildApplicantContent(context, animal)));
}

List<Widget> _buildApplicantContent(BuildContext context, AnimalRead animal) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(
        LocaleKeys.animalApplicant.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(
        firstCaption: LocaleKeys.animalCuratorName.tr(),
        firstValue: animal.applicantFullName,
      ),
      CardData(firstCaption: LocaleKeys.animalCuratorPhone.tr(), firstValue: animal.applicantPhone),
      CardData(firstCaption: LocaleKeys.animalCuratorEmail.tr(), firstValue: animal.applicantEmail),
      CardData(firstCaption: LocaleKeys.animalSocialLink.tr(), firstValue: null),
      CardData(firstCaption: LocaleKeys.animalTransferAct.tr(), firstValue: null),
    ], valueStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.0)),
    const SizedBox(height: 64.0),
  ];
}
