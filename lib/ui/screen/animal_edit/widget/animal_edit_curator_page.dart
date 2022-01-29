import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_curator_screen_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimalEditCuratorPage extends AnimalEditPage {
  const AnimalEditCuratorPage({
    required Animal animal,
    required bool isEdit,
    required void Function(bool isValid) validate,
    Key? key,
  }) : super(
          isEdit: isEdit,
          animal: animal,
          validate: validate,
          key: key,
        );

  @override
  State<AnimalEditCuratorPage> createState() => _AnimalEditCuratorPageState();
}

class _AnimalEditCuratorPageState extends State<AnimalEditCuratorPage> {
  final _curatorController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  Curator? _curator;

  @override
  void initState() {
    super.initState();
    _setControllers(widget.animal);
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
            title: StringRes.current.animalCurator,
            actions: [
              CupertinoButton(
                padding: const EdgeInsets.only(),
                child: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: ColorRes.accent,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: _buildCuratorCard(),
        ),
      ],
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
          onPressed: _searchCurator,
        ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorPhone,
            enabled: false,
            controller: _phoneController,
          ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorEmail,
            enabled: false,
            controller: _emailController,
          ),
        if (_curator != null)
          EditCardData(
            label: StringRes.current.animalCuratorAddress,
            enabled: false,
            controller: _addressController,
          ),
      ],
    );
  }

  Future<void> _searchCurator() async {
    final result = await Navigator.push(context, SearchCuratorScreenRoute());
    if (result != null) {
      _curator = result;
      _curatorController.text = result.fullName ?? '';
      _phoneController.text = result.phoneNumber ?? '';
      _emailController.text = result.email ?? '';
      _addressController.text = result.address ?? '';
    }
  }

  void _setControllers(Animal value) {
    if (value.curator != null) setState(() => _curator = Curator.fromJson(value.curator));
    _curatorController.text = value.curatorFullName ?? '';
    _phoneController.text = _curator?.phoneNumber ?? '';
    _emailController.text = _curator?.email ?? '';
    _addressController.text = _curator?.address ?? '';
  }
}
