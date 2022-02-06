import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalEditApplicantPage extends AnimalEditPage {
  const AnimalEditApplicantPage({
    required AnimalRead animal,
    required bool isEdit,
    required GlobalKey<FormState> formKey,
    Key? key,
  }) : super(
          isEdit: isEdit,
          animal: animal,
          key: key,
          formKey: formKey,
        );

  @override
  State<AnimalEditApplicantPage> createState() => _AnimalEditApplicantPageState();
}

class _AnimalEditApplicantPageState extends State<AnimalEditApplicantPage>
    with AnimalPageHolderListener {
  final _applicantNameController = TextEditingController();
  final _applicantLastNameController = TextEditingController();
  final _applicantPhoneController = TextEditingController();
  final _applicantSocialController = TextEditingController();
  final _applicantEmailController = TextEditingController();
  Applicant? _applicant;

  @override
  void initState() {
    super.initState();
    _setControllers(widget.animal);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addPageListener(context);
  }

  @override
  void dispose() {
    removePageListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
        SliverToBoxAdapter(
          child: SubtitleWidget(title: StringRes.current.animalApplicant),
        ),
        SliverToBoxAdapter(
          child: _buildActUploadButtons(),
        ),
        SliverToBoxAdapter(
          child: _buildApplicantCard(),
        ),
      ],
    );
  }

  Widget _buildActUploadButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        bottom: 8.0,
        right: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.current.animalUploadAct,
            style: StyleRes.content.copyWith(
              fontSize: 16.0,
              color: ColorRes.textPrimary,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.all(4.0),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: ColorRes.accent,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 16.0),
              CupertinoButton(
                padding: const EdgeInsets.all(4.0),
                child: const Icon(
                  Icons.note_add_outlined,
                  color: ColorRes.accent,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _buildApplicantCard() {
    return Form(
      key: widget.formKey,
      child: AnimalEditCard(
        [
          EditCardData(
            label: StringRes.current.animalCuratorName + ' *',
            controller: _applicantNameController,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: StringRes.current.animalCuratorLastName + ' *',
            controller: _applicantLastNameController,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: StringRes.current.animalCuratorPhone + ' *',
            controller: _applicantPhoneController,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: StringRes.current.animalSocialLink,
            controller: _applicantSocialController,
          ),
          EditCardData(
            label: StringRes.current.animalCuratorEmail,
            controller: _applicantEmailController,
          ),
        ],
      ),
    );
  }

  void _setControllers(AnimalRead value) {
    if (value.applicant != null) setState(() => _applicant = Applicant.fromJson(value.applicant));
    _applicantNameController.text = _applicant?.firstName ?? '';
    _applicantLastNameController.text = _applicant?.lastName ?? '';
    _applicantPhoneController.text = _applicant?.phoneNumber ?? '';
    _applicantSocialController.text = _applicant?.contactDetails ?? '';
    _applicantEmailController.text = _applicant?.email ?? '';
  }

  @override
  void onChangePage() {
    if (page != 4) return;
    final applicant = Applicant(
      firstName: _applicantNameController.text,
      lastName: _applicantLastNameController.text,
      phoneNumber: _applicantPhoneController.text,
      contactDetails: _applicantSocialController.text,
      email: _applicantEmailController.text,
    );
    Provider.of<AnimalEditHolder>(context, listen: false).copyWith(
      applicant: applicant.toJson(),
      applicantId: _applicant?.id,
    );
  }
}
