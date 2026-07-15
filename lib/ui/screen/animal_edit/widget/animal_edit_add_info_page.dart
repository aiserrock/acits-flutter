import 'dart:math';

import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/animal_sex_enum.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');
const _chipDateRange = Duration(days: 365 * 50);
const _birthDateRange = Duration(days: 365 * 200);

class AnimalEditAddInfoPage extends AnimalEditPage {
  const AnimalEditAddInfoPage({
    required super.animal,
    required super.isEdit,
    required GlobalKey<FormState> super.formKey,
    super.key,
  });

  @override
  State<AnimalEditAddInfoPage> createState() => _AnimalEditAddInfoPageState();
}

class _AnimalEditAddInfoPageState extends State<AnimalEditAddInfoPage> with AnimalPageHolderListener {
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
        SliverToBoxAdapter(child: SubtitleWidget(title: LocaleKeys.animalAdditionalInfo.tr())),
        SliverToBoxAdapter(child: _buildAddinionalCard()),
      ],
    );
  }

  Widget _buildAddinionalCard() {
    return Form(
      key: widget.formKey,
      child: FormEditCard([
        EditCardData(label: LocaleKeys.animalAge.tr(), content: _buildAgeTabSelector()),
        if (_currentAgeTab == 0) EditCardData(content: _buildAgeFields()),
        if (_currentAgeTab == 1)
          EditCardData(
            label: LocaleKeys.animalBirth.tr(),
            controller: _birthController,
            suffix: Icon(Icons.calendar_today_outlined, color: Theme.of(context).colorScheme.primary),
            onPressed: _setBirthDate,
          ),
        EditCardData(
          label: '${LocaleKeys.animalSex.tr()}*',
          controller: _sexController,
          suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).colorScheme.primary),
          validator: Validator.emptyValidator,
          onPressed: () => _selectGender(context),
        ),
        EditCardData(label: LocaleKeys.aninmalSize.tr(), controller: _heightController, decimalOnly: true),
        EditCardData(label: LocaleKeys.animalWeight.tr(), controller: _weightController, decimalOnly: true),
        EditCardData(label: LocaleKeys.animalColor.tr(), controller: _colorController),
        EditCardData(label: LocaleKeys.animalSpecSigns.tr(), controller: _specController),
        EditCardData(
          label: LocaleKeys.animalChip.tr(),
          controller: _chipController,
          validator: (value) {
            if (_dateChipController.text.isNotEmpty && (value == null || value.isEmpty)) {
              return '';
            }
            return null;
          },
        ),
        EditCardData(
          label: LocaleKeys.animalChipDate.tr(),
          controller: _dateChipController,
          suffix: Icon(Icons.calendar_today_outlined, color: Theme.of(context).colorScheme.primary),
          validator: (value) {
            if (_chipController.text.isNotEmpty && (value == null || value.isEmpty)) {
              return '';
            }
            return null;
          },
          onPressed: _setChipDate,
        ),
      ]),
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
                LocaleKeys.animalAgeAppox.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _currentAgeTab == 0
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
            1: Text(
              LocaleKeys.animalAgeExact.tr(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: _currentAgeTab == 1
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.surface,
              ),
            ),
          },
          backgroundColor: context.appColors.indicatorActive,
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
              decoration: InputDecoration(labelText: LocaleKeys.animalQtyYear.tr()),
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
                decoration: InputDecoration(labelText: LocaleKeys.animalQtyMonth.tr()),
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
    final months = (int.tryParse(_ageYearController.text) ?? 0) * 12 + (int.tryParse(_ageMonthController.text) ?? 0);
    _ageYearController.text = (months ~/ 12).toString();
    _ageMonthController.text = (months % 12).toString();
  }

  void _selectGender(BuildContext ctx) {
    final actionList = AnimalGender.values.map<MapEntry<Widget, dynamic Function()>>(
      (gender) => MapEntry(
        Text(
          gender.value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
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
      builder: (ctx) => bsSelectorActions(ctx, <Widget, dynamic Function()>{
        for (final action in actionList) action.key: action.value,
      }),
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
    _dateChipController.text = value.dateOfChipping != null ? _dateFormatter.format(value.dateOfChipping!) : '';
  }

  @override
  void onChangePage() {
    if (page != 2) return;
    final attr = <AnimalAttributeValue>[];
    if (_sexController.text.isNotEmpty) {
      final sexAttribute = (getIt<ConfigService>().animalAttributes ?? []).firstWhereOrNull(
        (element) => element.name == 'sex',
      );
      if (sexAttribute != null) {
        attr.add(
          AnimalAttributeValue(
            attrId: sexAttribute.id ?? 0,
            isRequired: sexAttribute.isRequired,
            name: sexAttribute.name,
            value: _sexController.text,
          ),
        );
      }
    }
    if (_colorController.text.isNotEmpty) {
      final colorAttribute = (getIt<ConfigService>().animalAttributes ?? []).firstWhereOrNull(
        (element) => element.name == 'color',
      );
      if (colorAttribute != null) {
        attr.add(
          AnimalAttributeValue(
            attrId: colorAttribute.id ?? 0,
            isRequired: colorAttribute.isRequired,
            name: colorAttribute.name,
            value: _colorController.text,
          ),
        );
      }
    }
    if (_specController.text.isNotEmpty) {
      final signAttribute = (getIt<ConfigService>().animalAttributes ?? []).firstWhereOrNull(
        (element) => element.name == 'special_signs',
      );
      if (signAttribute != null) {
        attr.add(
          AnimalAttributeValue(
            attrId: signAttribute.id ?? 0,
            isRequired: signAttribute.isRequired,
            name: signAttribute.name,
            value: _specController.text,
          ),
        );
      }
    }
    final months = (int.tryParse(_ageYearController.text) ?? 0) * 12 + (int.tryParse(_ageMonthController.text) ?? 0);
    final birth = _currentAgeTab == 0 ? DateTime.now().subtract(Duration(days: max(months * 30, 1))) : birthDate;

    Provider.of<AnimalEditHolder>(context, listen: false).copyWith(
      birthDate: birth,
      animalAttributes: attr,
      height: _heightController.text,
      weight: _weightController.text,
      chippingCode: _chipController.text,
      dateOfChipping: chipDate,
    );
  }
}
