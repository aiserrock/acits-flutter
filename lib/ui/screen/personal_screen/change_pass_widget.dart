import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/util/validator.dart';

class ChangePassWidget extends StatefulWidget {
  const ChangePassWidget({super.key});

  @override
  State<ChangePassWidget> createState() => _ChangePassWidgetState();
}

class _ChangePassWidgetState extends State<ChangePassWidget> {
  _ChangePassWidgetState() : _personalService = getIt<PersonalService>();

  final PersonalService _personalService;
  final _formKey = GlobalKey<FormState>();
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  WidgetState<Object> _state = WidgetState(Object());
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Изменить пароль'),
      content: SizedBox(
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: StateBuilder(
            state: _state,
            builder: (_, __) => _buildForm(),
            loader: (_) => Center(
              child: Lottie.asset(
                LottieRes.loading,
              ),
            ),
            errorBuilder: (_, __) => Container(),
          ),
        ),
      ),
      actions: _state.isLoading
          ? []
          : [
              CupertinoDialogAction(
                onPressed: Navigator.of(context).pop,
                child: Text(
                  StringRes.current.commonCancel,
                ),
              ),
              CupertinoDialogAction(
                onPressed: () => _submit(context),
                child: Text(
                  StringRes.current.commonEdit,
                ),
              ),
            ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: FormEditCard(
        [
          EditCardData(
            label: ' Старый пароль',
            controller: _oldPassController,
            isObscure: true,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: ' Новый пароль',
            controller: _newPassController,
            suffix: CupertinoButton(
              onPressed: () => setState(() => _isObscure = !_isObscure),
              child: _isObscure ? Assets.icon.visible.svg() : Assets.icon.visibleOff.svg(),
            ),
            isObscure: _isObscure,
            validator: Validator.emptyValidator,
          ),
          if (_isObscure)
            EditCardData(
              label: ' Повторить пароль',
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

  void _submit(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      _showMessage(context, 'Заполните значения');
      return;
    }
    setState(() => _state = WidgetState()..loading());
    _personalService.changePass(_oldPassController.text, _newPassController.text).then(
      (_) {
        _showMessage(context, 'Пароль успешно изменен');
        Navigator.of(context).pop();
      },
    ).catchError((e) {
      final error = e is MessagedException ? e.error : null;
      _showMessage(context, 'Не удалось изменить пароль\n${error is String ? error : ''}');
      setState(() => _state = WidgetState(Object()));
    });
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
