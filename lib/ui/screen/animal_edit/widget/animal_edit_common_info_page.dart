import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:go_router/go_router.dart';

class AnimalEditCommonInfoPage extends AnimalEditPage {
  const AnimalEditCommonInfoPage({
    required super.animal,
    required super.isEdit,
    required GlobalKey<FormState> super.formKey,
    super.key,
  });

  @override
  State<AnimalEditCommonInfoPage> createState() => _AnimalEditCommonInfoPageState();
}

class _AnimalEditCommonInfoPageState extends State<AnimalEditCommonInfoPage>
    with AnimalPageHolderListener {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _familyController = TextEditingController();
  final _kindController = TextEditingController();
  Species? _categorySpec;
  Species? _familySpec;
  Species? _kindSpec;

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
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
        SliverToBoxAdapter(child: _buildImage()),
        const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        SliverToBoxAdapter(child: SubtitleWidget(title: LocaleKeys.animalCommonInfo.tr())),
        SliverToBoxAdapter(child: _buildCommonCard()),
      ],
    );
  }

  Widget _buildImage() {
    final avatar = widget.animal.thumb;
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: (widget.isEdit && avatar != null) ? NetworkImage(avatar) : null,
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
                        child: const Icon(Icons.photo_camera, color: ColorRes.accent, size: 32.0),
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 32.0,
                        child: Divider(thickness: 2.0, color: ColorRes.accent),
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

  Widget _buildCommonCard() {
    return Form(
      key: widget.formKey,
      child: FormEditCard([
        EditCardData(label: LocaleKeys.animalName.tr(), controller: _nameController),
        EditCardData(
          label: '${LocaleKeys.animalCategory.tr()} *',
          controller: _categoryController,
          suffix: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.accent),
          onPressed: _searchCategory,
          validator: Validator.emptyValidator,
        ),
        EditCardData(
          label: '${LocaleKeys.animalAnimalFamily.tr()} *',
          controller: _familyController,
          suffix: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.accent),
          onPressed: _searchFamily,
          validator: Validator.emptyValidator,
        ),
        EditCardData(
          label: '${LocaleKeys.animalAnimalKind.tr()} *',
          controller: _kindController,
          suffix: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.accent),
          onPressed: _searchKind,
          validator: Validator.emptyValidator,
        ),
      ]),
    );
  }

  Future<void> _searchCategory() async {
    final result = await context.push<Species>(AppRoutes.searchSpec);
    if (!mounted) return;
    if (result != null) {
      setState(() {
        _categorySpec = result;
        _familySpec = null;
        _kindSpec = null;
        _kindController.clear();
        _familyController.clear();
        _categoryController.text = result.name;
      });
    }
  }

  Future<void> _searchFamily() async {
    if (_categorySpec == null) {
      await _searchCategory();
      if (_categorySpec == null) return;
    }
    if (!mounted) return;

    final result = await context.push<Species>(AppRoutes.searchSpec, extra: _categorySpec);
    if (!mounted) return;
    if (result != null) {
      setState(() {
        _familySpec = result;
        _kindSpec = null;
        _kindController.clear();
        _familyController.text = result.name;
      });
    }
  }

  Future<void> _searchKind() async {
    if (_familySpec == null) {
      await _searchFamily();
      if (_familySpec == null) return;
    }
    if (!mounted) return;

    final result = await context.push<Species>(AppRoutes.searchSpec, extra: _familySpec);
    if (!mounted) return;
    if (result != null) {
      setState(() {
        _kindSpec = result;
        _kindController.text = result.name;
      });
    }
  }

  void _setControllers(AnimalRead value) {
    _nameController.text = value.name ?? '';
    _categoryController.text = value.specCategory ?? '';
    _familyController.text = value.specFamily ?? '';
    _kindController.text = value.specKind ?? '';
  }

  @override
  void onChangePage() {
    if (page != 0) return;
    final spec = <String, dynamic>{
      'category_name': _categoryController.text,
      'parent_name': _familyController.text,
      'name': _kindController.text,
      'id': _kindSpec?.id ?? widget.animal.idSpec,
    };
    Provider.of<AnimalEditHolder>(
      context,
      listen: false,
    ).copyWith(name: _nameController.text, spec: spec);
  }
}
