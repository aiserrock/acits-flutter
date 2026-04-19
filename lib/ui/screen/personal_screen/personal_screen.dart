import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/ui/screen/personal_screen/change_pass_widget.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

/// Экран личного кабинета пользователя
class PersonalScreen extends StatefulWidget {
  const PersonalScreen({required this.isChangePass, super.key});

  final bool isChangePass;

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  _PersonalScreenState() : _personalService = getIt<PersonalService>();

  final PersonalService _personalService;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  ScreenDataState<UserSerializers> _state = ScreenDataState()..loading();
  bool _fabVisible = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios, color: ColorRes.accent),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.personMyData, style: const TextStyle(color: ColorRes.textPrimary)),
        centerTitle: true,
      ),
      floatingActionButton: (_state.isContent && _fabVisible) ? _buildFab() : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StateBuilder<UserSerializers>(
      state: _state,
      builder: (_, user) => _buildContent(user),
      loader: (_) => const LoaderHolderWidget(),
      errorBuilder: (_, e) => ErrorHolderWidget(error: e, onPressed: _init),
    );
  }

  Widget _buildContent(UserSerializers user) {
    return KeyboardDismissOnTap(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 64.0),
          child: Form(
            child: Builder(
              builder: (context) {
                return FormEditCard([
                  EditCardData(
                    label: l10n.loginLoginLabel,
                    enabled: false,
                    initValue: user.username,
                  ),
                  EditCardData(
                    label: l10n.loginPassLabel,
                    enabled: false,
                    initValue: '••••••••',
                    suffix: const Icon(Icons.edit, color: ColorRes.accent),
                    onPressed: () => _onPassChange(context),
                  ),
                  EditCardData(
                    label: l10n.animalCuratorName,
                    controller: _firstNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: l10n.animalCuratorLastName,
                    controller: _lastNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: l10n.regFathersName,
                    controller: _fatherNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: l10n.animalCuratorPhone,
                    controller: _phoneController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: l10n.animalCuratorEmail,
                    controller: _emailController,
                    onChanged: _onFieldChanged,
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: _submit,
      backgroundColor: ColorRes.accent,
      child: const Icon(Icons.done_all, color: ColorRes.foreground),
    );
  }

  void _onFieldChanged(String value) {
    final data = _state.value;
    if (data == null) return;
    final changed =
        data.copyWith(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          fathersName: _fatherNameController.text,
          phoneNumber: _phoneController.text,
          email: _emailController.text,
        ) !=
        data;
    if (changed != _fabVisible) {
      setState(() => _fabVisible = changed);
    }
  }

  void _onPassChange(BuildContext context) {
    showCupertinoDialog(context: context, builder: (_) => const ChangePassWidget());
  }

  void _init() {
    setState(() => _state = ScreenDataState()..loading());
    _personalService
        .fetchPersonal(force: true)
        .then((user) {
          if (!mounted) return;
          setState(() => _state = ScreenDataState(user));
          _firstNameController.text = user.firstName ?? '';
          _lastNameController.text = user.lastName ?? '';
          _fatherNameController.text = user.fathersName ?? '';
          _phoneController.text = user.phoneNumber ?? '';
          _emailController.text = user.email ?? '';
          if (widget.isChangePass) {
            _onPassChange(context);
          }
        })
        .catchError((e) {
          setState(() => _state = ScreenDataState()..error = e);
        });
  }

  void _submit() {
    final data = _state.value;
    if (data == null) return;
    setState(() => _state = ScreenDataState()..loading());
    final changed = data.copyWith(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      fathersName: _fatherNameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
    );
    _personalService
        .changePersonal(changed)
        .then((value) => setState(() => _state = ScreenDataState(value)))
        .catchError((e) {
          setState(() => _state = ScreenDataState()..error = e);
        });
  }
}
