import 'package:util/util.dart';
import 'package:localization/localization.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:personal/domain/domain.dart';
import 'package:personal/presentation/presentation.dart';

class ChangePassWidget extends StatelessWidget {
  const ChangePassWidget({required this.repository, super.key});

  final PersonalRepository repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ChangePassCubit(repository), child: const _ChangePassView());
  }
}

class _ChangePassView extends StatefulWidget {
  const _ChangePassView();

  @override
  State<_ChangePassView> createState() => _ChangePassViewState();
}

class _ChangePassViewState extends State<_ChangePassView> {
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _oldPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePassCubit, DataState<void>>(
      builder: (context, state) {
        return CupertinoAlertDialog(
          title: Text(LocaleKeys.personalChangePass.tr()),
          content: SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: DataStateBuilder<void>(
                state: state,
                builder: (_, _) => _buildForm(),
                loader: (_) => Center(child: Lottie.asset(PersonalLottieRes.loading)),
                errorBuilder: (_, _) => _buildForm(),
              ),
            ),
          ),
          actions: state.isLoading
              ? []
              : [
                  CupertinoDialogAction(
                    onPressed: Navigator.of(context).pop,
                    child: Text(LocaleKeys.commonCancel.tr()),
                  ),
                  CupertinoDialogAction(onPressed: _submit, child: Text(LocaleKeys.commonEdit.tr())),
                ],
        );
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: FormEditCard(
        [
          EditCardData(
            label: LocaleKeys.personalOldPass.tr(),
            controller: _oldPassController,
            isObscure: true,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: LocaleKeys.personalNewPass.tr(),
            controller: _newPassController,
            suffix: CupertinoButton(
              onPressed: () => setState(() => _isObscure = !_isObscure),
              child: _isObscure ? PersonalAssets.visible() : PersonalAssets.visibleOff(),
            ),
            isObscure: _isObscure,
            validator: Validator.emptyValidator,
          ),
          if (_isObscure)
            EditCardData(
              label: LocaleKeys.personalRePass.tr(),
              isObscure: _isObscure,
              validator: (value) => _newPassController.text != value ? '' : null,
            ),
        ],
        background: Colors.transparent,
        padding: const EdgeInsets.only(top: 16.0),
        margin: const EdgeInsets.all(0.0),
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _showMessage(LocaleKeys.personalEmptyFieldErrorMsg.tr());
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final cubit = context.read<ChangePassCubit>();

    final success = await cubit.submit(_oldPassController.text, _newPassController.text);
    if (!mounted) return;

    if (success) {
      messenger.showSnackBar(SnackBar(content: Text(LocaleKeys.personalPassChanged.tr())));
      navigator.pop();
      return;
    }

    final state = cubit.state;
    final rawError = state is DataError<void> ? state.error : null;
    // Раньше сюда попадал MessagedException с телом ответа сервера; теперь —
    // типизированный Failure. Показываем ту же пару «префикс + деталь»: деталь
    // несёт только ServerFailure (note из ответа), остальные варианты дают
    // голый префикс — как и прежде при отсутствующем теле ответа.
    final detail = rawError is ServerFailure ? (rawError.note ?? '') : '';
    messenger.showSnackBar(SnackBar(content: Text('${LocaleKeys.personalChangeErrorMsg.tr()}$detail')));
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
