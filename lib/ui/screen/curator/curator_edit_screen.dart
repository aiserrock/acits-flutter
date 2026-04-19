import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// Экран создания или редактирования куратора
class CuratorEditScreen extends StatefulWidget {
  const CuratorEditScreen({this.curatorId, super.key});

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

  ScreenDataState<Curator?> _state = ScreenDataState<Curator?>()..content(Curator());

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
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
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
              onPressed: _onSubmit,
              backgroundColor: ColorRes.accent,
              child: const Icon(Icons.done_all, color: Colors.white),
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
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, _) => Container(),
          builder: (_, _) => _buildApplicantCard(),
        ),
      ),
    );
  }

  Widget _buildApplicantCard() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: FormEditCard([
            EditCardData(
              label: '${StringRes.current.animalCuratorName} *',
              controller: _nameController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(
              label: StringRes.current.animalCuratorLastName,
              controller: _lastNameController,
            ),
            EditCardData(
              label: '${StringRes.current.animalCuratorPhone} *',
              controller: _phoneController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(label: StringRes.current.animalCuratorEmail, controller: _emailController),
            EditCardData(
              label: StringRes.current.animalCuratorAddress,
              controller: _addressController,
            ),
          ]),
        ),
      ],
    );
  }

  Future<void> _init() async {
    if (!_isEdit) return;
    _state = ScreenDataState<Curator>()..loading();
    await _service
        .fetchCuratorById(id: widget.curatorId!)
        .then((value) {
          _setControllers(value);
          setState(() => _state = ScreenDataState()..content(value));
        })
        .catchError((e) {
          setState(() => _state = ScreenDataState().error = e);
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
    setState(() => _state = ScreenDataState<Curator>()..loading());
    Curator? result;
    if (_isEdit) {
      result = await _service.updateCurator(id: widget.curatorId!, curator: curator).catchError((
        e,
      ) {
        setState(() => _state = ScreenDataState().error = e);
        return null;
      });
    } else {
      result = await _service.createCurator(curator: curator).catchError((e) {
        setState(() => _state = ScreenDataState().error = e);
        return null;
      });
    }
    if (result != null) _navigator.pop(result);
  }
}
