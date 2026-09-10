import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

/// [UiTextField] — токен-ориентированное поле: label / hint / prefix / suffix /
/// obscure. Обводка и цвета берутся из `inputDecorationTheme`.
class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          UiTextField(label: 'Label', hint: 'Hint'),
          SizedBox(height: 16.0),
          UiTextField(label: 'Email', hint: 'you@acits.ru', prefixIcon: Icon(Icons.mail_outline)),
          SizedBox(height: 16.0),
          UiTextField(
            label: 'Пароль',
            hint: '••••••',
            obscureText: true,
            prefixIcon: Icon(IconRes.visible),
            suffixIcon: Icon(IconRes.visibleOff),
          ),
          SizedBox(height: 16.0),
          UiTextField(label: 'Телефон', hint: '+7', keyboardType: TextInputType.phone),
        ],
      ),
    );
  }
}
