import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit/ui_kit.dart' show FormEditCard, EditCardData;

import 'package:shell/src/shell_exports.dart';
import 'package:shell/navigation/app_router.dart';
import 'package:shell/presentation/animal_edit/data/animal_edit_data_holder.dart';
import 'package:media/media.dart' show SearchTypeKey;
import 'package:shell/presentation/animal_edit/widget/animal_edit_page.dart';
import 'package:shell/presentation/animal_edit/widget/subtitle_widget.dart';

class AnimalEditCuratorPage extends AnimalEditPage {
  const AnimalEditCuratorPage({required super.animal, required super.isEdit, super.key});

  @override
  State<AnimalEditCuratorPage> createState() => _AnimalEditCuratorPageState();
}

class _AnimalEditCuratorPageState extends State<AnimalEditCuratorPage> with AnimalPageHolderListener {
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
            title: LocaleKeys.animalCurator.tr(),
            actions: [
              if (_curator != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CupertinoButton(
                    padding: const EdgeInsets.only(),
                    child: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary, size: 40.0),
                    onPressed: () => _addEditCurator(context, curatorId: _curator?.id),
                  ),
                ),
              CupertinoButton(
                padding: const EdgeInsets.only(),
                child: Icon(Icons.add_circle_outline_rounded, color: Theme.of(context).colorScheme.primary, size: 40.0),
                onPressed: () => _addEditCurator(context),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
        SliverToBoxAdapter(child: _buildCuratorCard()),
      ],
    );
  }

  Widget _buildCuratorCard() {
    return Form(
      child: FormEditCard([
        EditCardData(
          label: LocaleKeys.animalPickCurator.tr(),
          controller: _curatorController,
          suffix: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).colorScheme.primary),
          onPressed: _searchCurator,
        ),
        if (_curator != null)
          EditCardData(label: LocaleKeys.animalCuratorPhone.tr(), enabled: false, controller: _phoneController),
        if (_curator != null)
          EditCardData(label: LocaleKeys.animalCuratorEmail.tr(), enabled: false, controller: _emailController),
        if (_curator != null)
          EditCardData(label: LocaleKeys.animalCuratorAddress.tr(), enabled: false, controller: _addressController),
      ]),
    );
  }

  Future<void> _searchCurator() async {
    final result = await context.push<Curator>(AppRoutes.searchPath(SearchTypeKey.curator));
    if (result != null) {
      setState(() => _curator = result);
      _curatorController.text = result.fullName;
      _phoneController.text = result.phoneNumber;
      _emailController.text = result.email ?? '';
      _addressController.text = result.address ?? '';
    }
  }

  void _setControllers(AnimalEditFormState value) {
    final seeded = value.curator;
    if (seeded != null) setState(() => _curator = seeded);
    _curatorController.text = _curator?.fullName ?? '';
    _phoneController.text = _curator?.phoneNumber ?? '';
    _emailController.text = _curator?.email ?? '';
    _addressController.text = _curator?.address ?? '';
  }

  @override
  void onChangePage() {
    if (page != 3) return;
    Provider.of<AnimalEditHolder>(context, listen: false).update((prev) => prev.copyWith(curator: _curator));
  }

  Future<void> _addEditCurator(BuildContext context, {int? curatorId}) async {
    final result = await context.push<Curator>(
      curatorId == null ? AppRoutes.curatorEdit : '${AppRoutes.curatorEdit}?curatorId=$curatorId',
    );
    if (result != null) {
      setState(() => _curator = result);
      _curatorController.text = result.fullName;
      _phoneController.text = result.phoneNumber;
      _emailController.text = result.email ?? '';
      _addressController.text = result.address ?? '';
    }
  }
}
