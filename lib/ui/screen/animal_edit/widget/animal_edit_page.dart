import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_pager_holder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class AnimalEditPage extends StatefulWidget {
  const AnimalEditPage({
    required this.isEdit,
    required this.animal,
    this.formKey,
    Key? key,
  }) : super(key: key);

  final bool isEdit;
  final AnimalRead animal;
  final GlobalKey<FormState>? formKey;
}

mixin AnimalPageHolderListener {
  BuildContext? _pageHolderContext;
  AnimalEditPagerHolder? _animalEditPagerHolder;

  void onChangePage() {}

  void addPageListener(BuildContext context) {
    _pageHolderContext = context;
    _animalEditPagerHolder = Provider.of<AnimalEditPagerHolder>(context, listen: false)
      ..addListener(onChangePage);
  }

  void removePageListener() {
    _animalEditPagerHolder?.removeListener(onChangePage);
  }

  int get page {
    final context = _pageHolderContext;
    return context != null ? Provider.of<AnimalEditPagerHolder>(context, listen: false).value : 0;
  }
}
