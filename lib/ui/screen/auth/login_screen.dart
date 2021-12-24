import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        title: const $AssetsImageGen().logoBar.svg(),
      ),
      backgroundColor: ColorRes.background,
      body: LayoutBuilder(builder: (_, constraints) {
        return KeyboardDismissOnTap(
          child: SizedBox(
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildForm(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    PrimaryButton(
                      onPressed: _submit,
                      text: 'Войти'.toUpperCase(),
                    ),
                    const SizedBox(height: 16.0),
                    MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(
                          color: ColorRes.accent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // const Spacer(),
                    const Text(
                      'ACITS – Система контроля за животными внутри приюта',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          child: Column(
            children: [
              SizedBox(
                height: 72.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Введите почту или логин',
                      labelText: 'Логин',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 72.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      // hintText: 'Введите почту или логин',
                      labelText: 'Пароль',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          transform:
              Transform.translate(offset: const Offset(-16.0, 8.0)).transform,
          child: MaterialButton(
            padding: const EdgeInsets.all(16.0),
            onPressed: () {},
            child: const Text(
              'Забыли пароль?',
              style: TextStyle(
                color: ColorRes.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submit() {}
}
