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

class AnimalEditCuratorPage extends AnimalEditPage {
  const AnimalEditCuratorPage({required super.animal, required super.isEdit, super.key});

  @override
  State<AnimalEditCuratorPage> createState() => _AnimalEditCuratorPageState();
}

class _AnimalEditCuratorPageState extends State<AnimalEditCuratorPage>
    with AnimalPageHolderListener {
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
            title: StringRes.current.animalCurator,
            actions: [
              if (_curator != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CupertinoButton(
                    padding: const EdgeInsets.only(),
                    child: const Icon(Icons.edit, color: ColorRes.accent, size: 40.0),
                    onPressed: () => _addEditCurator(context, curatorId: _curator?.id),
                  ),
                ),
              CupertinoButton(
                padding: const EdgeInsets.only(),
                child: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: ColorRes.accent,
                  size: 40.0,
                ),
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
          label: StringRes.current.animalPickCurator,
          controller: _curatorController,
          suffix: const Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.accent),
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
      ]),
    );
  }

  Future<void> _searchCurator() async {
    final result = await context.push<Curator>(AppRoutes.searchPath(SearchTypeKey.curator));
    if (result != null) {
      setState(() => _curator = result);
      _curatorController.text = result.fullName ?? '';
      _phoneController.text = result.phoneNumber ?? '';
      _emailController.text = result.email ?? '';
      _addressController.text = result.address ?? '';
    }
  }

  void _setControllers(AnimalRead value) {
    if (value.curator != null) setState(() => _curator = Curator.fromJson(value.curator));
    _curatorController.text = value.curatorFullName ?? '';
    _phoneController.text = _curator?.phoneNumber ?? '';
    _emailController.text = _curator?.email ?? '';
    _addressController.text = _curator?.address ?? '';
  }

  @override
  void onChangePage() {
    if (page != 3) return;
    final curator = _curator?.toJson();
    curator?['id'] = _curator?.id;
    Provider.of<AnimalEditHolder>(context, listen: false).copyWith(curator: curator);
  }

  Future<void> _addEditCurator(BuildContext context, {int? curatorId}) async {
    final result = await context.push<Curator>(
      curatorId == null ? AppRoutes.curatorEdit : '${AppRoutes.curatorEdit}?curatorId=$curatorId',
    );
    if (result != null) {
      setState(() => _curator = result);
      _curatorController.text = result.fullName ?? '';
      _phoneController.text = result.phoneNumber ?? '';
      _emailController.text = result.email ?? '';
      _addressController.text = result.address ?? '';
    }
  }
}
