import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/personal_screen/change_pass_widget.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/personal_cubit.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/personal_state.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';

/// Экран личного кабинета пользователя
class PersonalScreen extends StatelessWidget {
  const PersonalScreen({required this.isChangePass, super.key});

  final bool isChangePass;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalCubit(),
      child: _PersonalView(isChangePass: isChangePass),
    );
  }
}

class _PersonalView extends StatefulWidget {
  const _PersonalView({required this.isChangePass});

  final bool isChangePass;

  @override
  State<_PersonalView> createState() => _PersonalViewState();
}

class _PersonalViewState extends State<_PersonalView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _fatherNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
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
        title: Text(
          LocaleKeys.personMyData.tr(),
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      floatingActionButton: BlocBuilder<PersonalCubit, PersonalState>(
        builder: (context, state) =>
            (state.data.isContent && state.fabVisible) ? _buildFab() : const SizedBox.shrink(),
      ),
      body: BlocBuilder<PersonalCubit, PersonalState>(
        builder: (context, state) => DataStateBuilder<UserSerializers>(
          state: state.data,
          builder: (_, user) => _buildContent(user),
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(error: e, onPressed: _init),
        ),
      ),
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
                    label: LocaleKeys.loginLoginLabel.tr(),
                    enabled: false,
                    initValue: user.username,
                  ),
                  EditCardData(
                    label: LocaleKeys.loginPassLabel.tr(),
                    enabled: false,
                    initValue: '••••••••',
                    suffix: const Icon(Icons.edit, color: ColorRes.accent),
                    onPressed: () => _onPassChange(context),
                  ),
                  EditCardData(
                    label: LocaleKeys.animalCuratorName.tr(),
                    controller: _firstNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: LocaleKeys.animalCuratorLastName.tr(),
                    controller: _lastNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: LocaleKeys.regFathersName.tr(),
                    controller: _fatherNameController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: LocaleKeys.animalCuratorPhone.tr(),
                    controller: _phoneController,
                    onChanged: _onFieldChanged,
                  ),
                  EditCardData(
                    label: LocaleKeys.animalCuratorEmail.tr(),
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
    context.read<PersonalCubit>().onFieldsChanged(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      fathersName: _fatherNameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
    );
  }

  void _onPassChange(BuildContext context) {
    showCupertinoDialog(context: context, builder: (_) => const ChangePassWidget());
  }

  Future<void> _init() async {
    final user = await context.read<PersonalCubit>().load();
    if (!mounted || user == null) return;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _fatherNameController.text = user.fathersName ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    _emailController.text = user.email ?? '';
    if (widget.isChangePass) {
      _onPassChange(context);
    }
  }

  void _submit() {
    context.read<PersonalCubit>().submit(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      fathersName: _fatherNameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
    );
  }
}
