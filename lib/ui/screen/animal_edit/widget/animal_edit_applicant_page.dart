import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/util/validator.dart';

class AnimalEditApplicantPage extends AnimalEditPage {
  const AnimalEditApplicantPage({
    required super.animal,
    required super.isEdit,
    required GlobalKey<FormState> super.formKey,
    super.key,
  });

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
          child: SubtitleWidget(
            title: LocaleKeys.animalApplicant.tr(),
            actions: [
              if (_applicant != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CupertinoButton(
                    padding: const EdgeInsets.only(),
                    child: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40.0,
                    ),
                    onPressed: () => _addEditApplicant(context, applicantId: _applicant?.id),
                  ),
                ),
              CupertinoButton(
                padding: const EdgeInsets.only(),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40.0,
                ),
                onPressed: () => _addEditApplicant(context),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
        SliverToBoxAdapter(child: _buildApplicantCard()),
      ],
    );
  }

  Widget _buildApplicantCard() {
    return Form(
      key: widget.formKey,
      child: FormEditCard([
        EditCardData(
          label: LocaleKeys.animalCuratorName.tr(),
          controller: _applicantNameController,
          suffix: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: _searchApplicant,
        ),
        if (_applicant != null)
          EditCardData(
            label: '${LocaleKeys.animalCuratorLastName.tr()} *',
            controller: _applicantLastNameController,
            validator: Validator.emptyValidator,
            enabled: false,
          ),
        if (_applicant != null)
          EditCardData(
            label: '${LocaleKeys.animalCuratorPhone.tr()} *',
            controller: _applicantPhoneController,
            validator: Validator.emptyValidator,
            enabled: false,
          ),
        if (_applicant != null)
          EditCardData(
            label: LocaleKeys.animalSocialLink.tr(),
            controller: _applicantSocialController,
            enabled: false,
          ),
        if (_applicant != null)
          EditCardData(
            label: LocaleKeys.animalCuratorEmail.tr(),
            controller: _applicantEmailController,
            enabled: false,
          ),
      ]),
    );
  }

  void _setControllers(AnimalRead value) {
    if (value.applicant != null) setState(() => _applicant = value.applicant);
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
      id: _applicant?.id,
    );
    Provider.of<AnimalEditHolder>(
      context,
      listen: false,
    ).copyWith(applicant: applicant, applicantId: _applicant?.id);
  }

  Future<void> _searchApplicant() async {
    final result = await context.push<Applicant>(AppRoutes.searchPath(SearchTypeKey.applicant));
    if (result != null) {
      setState(() => _applicant = result);
      _applicantNameController.text = result.firstName;
      _applicantLastNameController.text = result.lastName;
      _applicantPhoneController.text = result.phoneNumber;
      _applicantEmailController.text = result.email ?? '';
      _applicantSocialController.text = result.contactDetails ?? '';
    }
  }

  Future<void> _addEditApplicant(BuildContext context, {int? applicantId}) async {
    final result = await context.push<Applicant>(
      applicantId == null
          ? AppRoutes.applicantEdit
          : '${AppRoutes.applicantEdit}?applicantId=$applicantId',
    );
    if (result != null) {
      setState(() => _applicant = result);
      _applicantNameController.text = result.firstName;
      _applicantLastNameController.text = result.lastName;
      _applicantPhoneController.text = result.phoneNumber;
      _applicantEmailController.text = result.email ?? '';
      _applicantSocialController.text = result.contactDetails ?? '';
    }
  }
}
