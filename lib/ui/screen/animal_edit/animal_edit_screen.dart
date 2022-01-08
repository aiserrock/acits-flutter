import 'dart:ui';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/animal_edit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');

/// Экран создания или редактирования существующих животных
class AnimalEditScreen extends StatefulWidget {
  const AnimalEditScreen({
    this.id,
    Key? key,
  }) : super(key: key);

  final int? id;

  @override
  _AnimalEditScreenState createState() => _AnimalEditScreenState();
}

class _AnimalEditScreenState extends State<AnimalEditScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  late final bool _isEdit;

  WidgetState<Animal> _editState = WidgetState<Animal>()..loading();

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _familyController = TextEditingController();
  final _kindController = TextEditingController();
  final _dateReceiptController = TextEditingController();
  final _statusController = TextEditingController();
  final _catchController = TextEditingController();

  int _currentAgeTab = 0;
  final _ageYearController = TextEditingController();
  final _ageMonthController = TextEditingController();
  final _birthController = TextEditingController();
  final _sexController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _weightUnitController = TextEditingController();
  final _colorController = TextEditingController();
  final _specController = TextEditingController();
  final _chipController = TextEditingController();
  final _dateChipController = TextEditingController();

  final _curatorController = TextEditingController();
  Curator? _curator;

  final _applicantNameController = TextEditingController();
  final _applicantLastNameController = TextEditingController();
  final _applicantPhoneController = TextEditingController();
  final _applicantSocialController = TextEditingController();
  final _applicantEmailController = TextEditingController();
  Applicant? _applicant;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.id != null;
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.id == null ? StringRes.current.animalAdd : StringRes.current.animalEdit,
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {},
            child: const Icon(
              Icons.done_sharp,
              color: ColorRes.accent,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: _isEdit
            ? StateBuilder<Animal>(
                state: _editState,
                loader: (_) => Container(),
                errorBuilder: (_, __) => Container(),
                builder: (context, snapshot) {
                  return RefreshIndicator(
                    child: _buildContent(),
                    onRefresh: _init,
                  );
                })
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          SliverToBoxAdapter(child: _buildImage()),
          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          SliverToBoxAdapter(
            child: _buildSubTitle(StringRes.current.animalCommonInfo),
          ),
          SliverToBoxAdapter(
            child: _buildCommonCard(),
          ),
          SliverToBoxAdapter(
            child: _buildSubTitle(StringRes.current.animalStatusAndJoin),
          ),
          SliverToBoxAdapter(
            child: _buildStatusCard(),
          ),
          SliverToBoxAdapter(
            child: _buildSubTitle(StringRes.current.animalAdditionalInfo),
          ),
          SliverToBoxAdapter(
            child: _buildAddinionalCard(),
          ),
          SliverToBoxAdapter(
            child: _buildCuratorTitle(),
          ),
          SliverToBoxAdapter(
            child: _buildCuratorCard(),
          ),
          SliverToBoxAdapter(
            child: _buildSubTitle(StringRes.current.animalApplicant),
          ),
          SliverToBoxAdapter(
            child: Padding(
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
            ),
          ),
          SliverToBoxAdapter(
            child: _buildApplicantCard(),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
        ],
      ),
    );
  }

  Widget _buildApplicantCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalCuratorName + ' *',
          controller: _applicantNameController,
        ),
        EditCardData(
          label: StringRes.current.animalCuratorLastName + ' *',
          controller: _applicantLastNameController,
        ),
        EditCardData(
          label: StringRes.current.animalCuratorPhone + ' *',
          controller: _applicantPhoneController,
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
    );
  }

  Widget _buildCuratorTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        bottom: 8.0,
        right: 16.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              StringRes.current.animalCurator,
              style: StyleRes.title.copyWith(fontSize: 22.0),
            ),
          ),
          const SizedBox(width: 16.0),
          CupertinoButton(
            padding: const EdgeInsets.only(),
            child: const Icon(
              Icons.add_circle_outline_rounded,
              color: ColorRes.accent,
              size: 32.0,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildCuratorCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalPickCurator,
          controller: _curatorController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorPhone,
            enabled: false,
            initValue: _curator?.phoneNumber,
          ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorEmail,
            enabled: false,
            initValue: _curator?.email,
          ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorAddress,
            enabled: false,
            initValue: _curator?.address,
          ),
      ],
    );
  }

  Widget _buildSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        bottom: 8.0,
      ),
      child: Text(
        title,
        style: StyleRes.title.copyWith(fontSize: 22.0),
      ),
    );
  }

  Widget _buildAddinionalCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalAge,
          content: _buildAgeTabSelector(),
        ),
        if (_currentAgeTab == 0)
          EditCardData(
            content: _buildAgeFields(),
          ),
        if (_currentAgeTab == 1)
          EditCardData(
            label: StringRes.current.animalBirth,
            controller: _birthController,
            suffix: const Icon(
              Icons.calendar_today_outlined,
              color: ColorRes.accent,
            ),
            onPressed: () {},
          ),
        EditCardData(
          label: StringRes.current.animalSex,
          controller: _sexController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        EditCardData(
          label: StringRes.current.aninmalSize,
          controller: _heightController,
          digitsOnly: true,
        ),
        EditCardData(
          label: StringRes.current.animalWeight,
          controller: _weightController,
          digitsOnly: true,
        ),
        EditCardData(
          label: StringRes.current.animalColor,
          controller: _colorController,
        ),
        EditCardData(
          label: StringRes.current.animalSpecSigns,
          controller: _specController,
        ),
        EditCardData(
          label: StringRes.current.animalChip,
          controller: _chipController,
        ),
        EditCardData(
          label: StringRes.current.animalChipDate,
          controller: _dateChipController,
          suffix: const Icon(
            Icons.calendar_today_outlined,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Padding _buildAgeFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _ageYearController,
              decoration: InputDecoration(
                labelText: StringRes.current.animalQtyYear,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) _checkAgeInput();
              },
              child: TextFormField(
                controller: _ageMonthController,
                decoration: InputDecoration(
                  labelText: StringRes.current.animalQtyMonth,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeTabSelector() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<int>(
          groupValue: _currentAgeTab,
          children: <int, Widget>{
            0: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                StringRes.current.animalAgeAppox,
                style: StyleRes.button.copyWith(
                  color: _currentAgeTab == 0 ? ColorRes.textPrimary : Colors.white,
                ),
              ),
            ),
            1: Text(
              StringRes.current.animalAgeExact,
              style: StyleRes.button.copyWith(
                color: _currentAgeTab == 1 ? ColorRes.textPrimary : Colors.white,
              ),
            ),
          },
          backgroundColor: ColorRes.indicatorActive,
          onValueChanged: (int? index) => setState(() {
            if (index != null) _currentAgeTab = index;
          }),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalDateAdmitt + ' *',
          controller: _dateReceiptController,
          suffix: const Icon(
            Icons.calendar_today_outlined,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        EditCardData(
          label: StringRes.current.animalAnimalStatus + ' *',
          controller: _statusController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        EditCardData(
          label: StringRes.current.animalCatchPlace + ' *',
          controller: _catchController,
        ),
      ],
    );
  }

  Widget _buildCommonCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalName,
          controller: _nameController,
        ),
        EditCardData(
          label: StringRes.current.animalCategory + ' *',
          controller: _categoryController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        EditCardData(
          label: StringRes.current.animalAnimalFamily + ' *',
          controller: _familyController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
        EditCardData(
          label: StringRes.current.animalAnimalKind,
          controller: _kindController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: (_isEdit && _editState.value?.avatar != null)
              ? NetworkImage(_editState.value!.avatar!)
              : null,
          foregroundColor: ColorRes.textSecondary,
          radius: 80.0,
        ),
        Positioned.fill(
          child: Center(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.photo_camera,
                          color: ColorRes.accent,
                          size: 32.0,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 32.0,
                        child: Divider(
                          thickness: 2.0,
                          color: ColorRes.accent,
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.photo_library_outlined,
                          color: ColorRes.accent,
                          size: 32.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _checkAgeInput() {
    if (_currentAgeTab != 0) return;
    final months = (int.tryParse(_ageYearController.text) ?? 0) * 12 +
        (int.tryParse(_ageMonthController.text) ?? 0);
    _ageYearController.text = (months ~/ 12).toString();
    _ageMonthController.text = (months % 12).toString();
  }

  Future<void> _init() async {
    if (widget.id == null) return;
    setState(() => _editState = WidgetState<Animal>()..loading());
    await getIt<AnimalService>()
        .fetchAnimalDetail(id: widget.id!)
        .then(
          (value) => setState(
            () {
              _editState = WidgetState()..content(value);
              _setControllers(value);
            },
          ),
        )
        .catchError((e) => setState(() => _editState = WidgetState()..error = e));
  }

  void _setControllers(Animal value) {
    _nameController.text = value.name ?? '';
    _categoryController.text = value.specCategory ?? '';
    _familyController.text = value.specFamily ?? '';
    _kindController.text = value.specKind ?? '';
    _dateReceiptController.text =
        value.dateJoined != null ? _dateFormatter.format(value.dateJoined!) : '';
    _statusController.text = value.statusString ?? '';
    _catchController.text = value.placeOfCatch ?? '';
    _birthController.text = value.birthDate != null ? _dateFormatter.format(value.birthDate!) : '';
    if (value.birthDate != null) setState(() => _currentAgeTab = 1);
    _sexController.text = value.sexString ?? '';
    _heightController.text = value.height ?? '';
    _weightController.text = value.weight ?? '';
    _colorController.text = value.colorString ?? '';
    _specController.text = value.specialSignsString ?? '';
    _chipController.text = value.chippingCode ?? '';
    _dateChipController.text =
        value.dateOfChipping != null ? _dateFormatter.format(value.dateOfChipping!) : '';
    if (value.curator != null) setState(() => _curator = Curator.fromJson(value.curator));
    _curatorController.text = value.curatorFullName ?? '';
    if (value.applicant != null) setState(() => _applicant = Applicant.fromJson(value.applicant));
    _applicantNameController.text = _applicant?.firstName ?? '';
    _applicantLastNameController.text = _applicant?.lastName ?? '';
    _applicantPhoneController.text = _applicant?.phoneNumber ?? '';
    _applicantSocialController.text = _applicant?.contactDetails ?? '';
    _applicantEmailController.text = _applicant?.email ?? '';
  }
}
