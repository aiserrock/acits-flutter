
import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';

abstract class AnimalEditPage extends StatefulWidget {
  const AnimalEditPage({
    required this.isEdit,
    required this.animal,
    required this.validate,
    Key? key,
  }) : super(key: key);

  final bool isEdit;
  final Animal animal;
  final void Function(bool isValid) validate;
}