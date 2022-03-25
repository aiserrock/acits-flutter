import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/animal_sex_enum.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');
const _chipDateRange = Duration(days: 365 * 50);
const _birthDateRange = Duration(days: 365 * 200);

class AnimalEditAddInfoPage extends AnimalEditPage {
  const AnimalEditAddInfoPage({
    required AnimalRead animal,
    required bool isEdit,
    required GlobalKey<FormState> formKey,
    Key? key,
  }) : super(
          isEdit: isEdit,
          animal: animal,
          formKey: formKey,
          key: key,
        );

  @override
  State<AnimalEditAddInfoPage> createState() => _AnimalEditAddInfoPageState();
}

class _AnimalEditAddInfoPageState extends State<AnimalEditAddInfoPage>
    with AnimalPageHolderListener {
  final _ageYearController = TextEditingController();
  final _ageMonthController = TextEditingController();
  final _birthController = TextEditingController();
  final _sexController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  //ignore: unused_field
  final _weightUnitController = TextEditingController();
  final _colorController = TextEditingController();
  final _specController = TextEditingController();
  final _chipController = TextEditingController();
  final _dateChipController = TextEditingController();

  DateTime? chipDate;
  DateTime? birthDate;
  AnimalGender? gender;
  int _currentAgeTab = 0;

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
          child: SubtitleWidget(title: StringRes.current.animalAdditionalInfo),
        ),
        SliverToBoxAdapter(
          child: _buildAddinionalCard(),
        ),
      ],
    );
  }

  Widget _buildAddinionalCard() {
    return Form(
      key: widget.formKey,
      child: AnimalEditCard(
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
              onPressed: _setBirthDate,
            ),
          EditCardData(
            label: StringRes.current.animalSex,
            controller: _sexController,
            suffix: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: ColorRes.accent,
            ),
            onPressed: () => _selectGender(context),
          ),
          EditCardData(
            label: StringRes.current.aninmalSize,
            controller: _heightController,
            decimalOnly: true,
          ),
          EditCardData(
            label: StringRes.current.animalWeight,
            controller: _weightController,
            decimalOnly: true,
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
            onPressed: _setChipDate,
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

  void _checkAgeInput() {
    if (_currentAgeTab != 0) return;
    final months = (int.tryParse(_ageYearController.text) ?? 0) * 12 +
        (int.tryParse(_ageMonthController.text) ?? 0);
    _ageYearController.text = (months ~/ 12).toString();
    _ageMonthController.text = (months % 12).toString();
  }

  void _selectGender(BuildContext ctx) {
    final actionList = AnimalGender.values.map<MapEntry<Widget, dynamic Function()>>(
      (gender) => MapEntry(
        Text(
          gender.value,
          style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
        ),
        () {
          _sexController.text = gender.value;
          this.gender = gender;
          Navigator.of(ctx).pop();
        },
      ),
    );
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => bsSelectorActions(
        ctx,
        <Widget, dynamic Function()>{for (final action in actionList) action.key: action.value},
      ),
    );
  }

  Future<void> _setChipDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(_chipDateRange),
      lastDate: now,
    );
    if (result != null) {
      chipDate = result;
      _dateChipController.text = _dateFormatter.format(result);
    }
  }

  Future<void> _setBirthDate() async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(_birthDateRange),
      lastDate: now,
    );
    if (result != null) {
      birthDate = result;
      _birthController.text = _dateFormatter.format(result);
    }
  }

  void _setControllers(AnimalRead value) {
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
  }

  @override
  void onChangePage() {
    if (page != 2) return;
    final attr = <AnimalAttributeValue>[];
    if (_sexController.text.isNotEmpty) {
      final sexAttribute = (getIt<ConfigService>().animalAttributes ?? [])
          .firstWhereOrNull((element) => element.name == 'sex');
      if (sexAttribute != null) {
        attr.add(AnimalAttributeValue(
          attrId: sexAttribute.id,
          isRequired: sexAttribute.isRequired,
          name: sexAttribute.name,
          value: _sexController.text,
        ));
      }
    }
    if (_colorController.text.isNotEmpty) {
      final colorAttribute = (getIt<ConfigService>().animalAttributes ?? [])
          .firstWhereOrNull((element) => element.name == 'color');
      if (colorAttribute != null) {
        attr.add(AnimalAttributeValue(
          attrId: colorAttribute.id,
          isRequired: colorAttribute.isRequired,
          name: colorAttribute.name,
          value: _colorController.text,
        ));
      }
    }
    if (_specController.text.isNotEmpty) {
      final signAttribute = (getIt<ConfigService>().animalAttributes ?? [])
          .firstWhereOrNull((element) => element.name == 'special_signs');
      if (signAttribute != null) {
        attr.add(AnimalAttributeValue(
          attrId: signAttribute.id,
          isRequired: signAttribute.isRequired,
          name: signAttribute.name,
          value: _specController.text,
        ));
      }
    }
    final months = (int.tryParse(_ageYearController.text) ?? 0) * 12 +
        (int.tryParse(_ageMonthController.text) ?? 0);
    final _birth =
        _currentAgeTab == 0 ? DateTime.now().subtract(Duration(days: months * 30)) : birthDate;
    Provider.of<AnimalEditHolder>(context, listen: false).copyWith(
      birthDate: _birth,
      animalAttributes: attr,
      height: _heightController.text,
      weight: _weightController.text,
      chippingCode: _chipController.text,
      dateOfChipping: chipDate,
    );
  }
}
