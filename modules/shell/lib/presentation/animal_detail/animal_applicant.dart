part of 'animal_detail_screen.dart';

SliverList _buildApplicantPage(BuildContext context, Animal animal) {
  return SliverList(delegate: SliverChildListDelegate(_buildApplicantContent(context, animal)));
}

List<Widget> _buildApplicantContent(BuildContext context, Animal animal) {
  final applicant = animal.applicant;
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
      child: Text(
        LocaleKeys.animalApplicant.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.0),
      ),
    ),
    AnimalContentCard([
      CardData(firstCaption: LocaleKeys.animalCuratorName.tr(), firstValue: applicant?.fullName),
      CardData(firstCaption: LocaleKeys.animalCuratorPhone.tr(), firstValue: applicant?.phoneNumber),
      CardData(firstCaption: LocaleKeys.animalCuratorEmail.tr(), firstValue: applicant?.email),
      CardData(firstCaption: LocaleKeys.animalSocialLink.tr(), firstValue: null),
      CardData(firstCaption: LocaleKeys.animalTransferAct.tr(), firstValue: null),
    ], valueStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.0)),
    const SizedBox(height: 64.0),
  ];
}
