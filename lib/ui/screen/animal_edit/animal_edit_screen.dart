import 'package:flutter/material.dart';

/// Экран создания или редактирования существующих животных
class AnimalEditScreen extends StatefulWidget {
  const AnimalEditScreen({
    this.id,
    Key? key,
  }) : super(key: key);

  final int? id;

  @override
  _AnimalEditScreenState createState() => _AnimalEditScreenState();
}

class _AnimalEditScreenState extends State<AnimalEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
