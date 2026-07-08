import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/ui/screen/personal_screen/cubit/change_pass_cubit.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/util/data_state.dart';
import 'package:acits_flutter/util/validator.dart';

class ChangePassWidget extends StatelessWidget {
  const ChangePassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ChangePassCubit(), child: const _ChangePassView());
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
          title: Text(l10n.personalChangePass),
          content: SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: DataStateBuilder<void>(
                state: state,
                builder: (_, _) => _buildForm(),
                loader: (_) => Center(child: Lottie.asset(LottieRes.loading)),
                errorBuilder: (_, _) => _buildForm(),
              ),
            ),
          ),
          actions: state.isLoading
              ? []
              : [
                  CupertinoDialogAction(
                    onPressed: Navigator.of(context).pop,
                    child: Text(l10n.commonCancel),
                  ),
                  CupertinoDialogAction(onPressed: _submit, child: Text(l10n.commonEdit)),
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
            label: l10n.personalOldPass,
            controller: _oldPassController,
            isObscure: true,
            validator: Validator.emptyValidator,
          ),
          EditCardData(
            label: l10n.personalNewPass,
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
              label: l10n.personalRePass,
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
      _showMessage(l10n.personalEmptyFieldErrorMsg);
      return;
    }

    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final cubit = context.read<ChangePassCubit>();

    final success = await cubit.submit(_oldPassController.text, _newPassController.text);
    if (!mounted) return;

    if (success) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.personalPassChanged)));
      navigator.pop();
      return;
    }

    final state = cubit.state;
    final rawError = state is DataError<void> ? state.error : null;
    final error = rawError is MessagedException ? rawError.error : null;
    messenger.showSnackBar(
      SnackBar(content: Text('${l10n.personalChangeErrorMsg}${error is String ? error : ''}')),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
