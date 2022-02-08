import 'dart:math';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';

/// Экран создания или редактирования куратора
class CuratorEditScreen extends StatefulWidget {
  const CuratorEditScreen({
    this.curatorId,
    Key? key,
  }) : super(key: key);

  final int? curatorId;

  @override
  State<CuratorEditScreen> createState() => _CuratorEditScreenState();
}

class _CuratorEditScreenState extends State<CuratorEditScreen> {
  late final StaffService _service;
  late final NavigatorState _navigator;

  late bool _isEdit;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  WidgetState<Curator?> _state = WidgetState<Curator?>()..content(Curator());

  @override
  void initState() {
    super.initState();
    _service = getIt<StaffService>();
    _isEdit = widget.curatorId != null;
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
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
          _isEdit ? StringRes.current.curatorEdit : StringRes.current.curatorAdd,
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      floatingActionButton: _state.isContent
          ? FloatingActionButton(
              child: const Icon(
                Icons.done_all,
                color: Colors.white,
              ),
              onPressed: _onSubmit,
              backgroundColor: ColorRes.accent,
            )
          : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: StateBuilder<Curator?>(
          state: _state,
          loader: (_) => const LoadingWidget(),
          errorBuilder: (_, __) => Container(),
          builder: (_, __) => _buildApplicantCard(),
        ),
      ),
    );
  }

  Widget _buildApplicantCard() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: AnimalEditCard(
            [
              EditCardData(
                label: StringRes.current.animalCuratorName + ' *',
                controller: _nameController,
                validator: Validator.emptyValidator,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorLastName + ' *',
                controller: _lastNameController,
                validator: Validator.emptyValidator,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorPhone + ' *',
                controller: _phoneController,
                validator: Validator.emptyValidator,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorEmail,
                controller: _emailController,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorAddress,
                controller: _addressController,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    if (!_isEdit) return;
    _state = WidgetState<Curator>()..loading();
    await Future.delayed(const Duration(seconds: 3));
    await _service.fetchCuratorById(id: widget.curatorId!).then((value) {
      _setControllers(value);
      setState(() => _state = WidgetState()..content(value));
    }).catchError((e) {
      setState(() => _state = WidgetState().error = e);
    });
  }

  void _setControllers(Curator? curator) {
    _nameController.text = curator?.firstName ?? '';
    _lastNameController.text = curator?.lastName ?? '';
    _emailController.text = curator?.email ?? '';
    _phoneController.text = curator?.phoneNumber ?? '';
    _addressController.text = curator?.address ?? '';
  }

  Future<void> _onSubmit() async {
    if (_state.isLoading) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    final curator = (_state.value ?? Curator()).copyWith(
      firstName: _nameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneController.text,
      address: _addressController.text,
      email: _emailController.text,
    );
    setState(() => _state = WidgetState<Curator>()..loading());
    Curator? result;
    await Future.delayed(const Duration(seconds: 3));
    if (_isEdit) {
      result = await _service
          .updateCurator(
        id: widget.curatorId!,
        curator: curator,
      )
          .catchError(
        (e) {
          setState(() => _state = WidgetState().error = e);
        },
      );
    } else {
      result = await _service
          .createCurator(
        curator: curator,
      )
          .catchError(
        (e) {
          setState(() => _state = WidgetState().error = e);
        },
      );
    }
    if (result != null) _navigator.pop(result);
  }
}

const _sizePart = .75;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.assetPath,
    Key? key,
  }) : super(key: key);

  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, cons) {
      final size = min(cons.maxHeight, cons.maxWidth) * _sizePart;
      return Center(
        child: Lottie.asset(
          assetPath ?? 'assets/lottie/loading.json',
          height: size,
          width: size,
        ),
      );
    });
  }
}
