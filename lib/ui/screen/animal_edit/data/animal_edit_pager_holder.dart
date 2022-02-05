import 'package:flutter/material.dart';

class AnimalEditPagerHolder extends ChangeNotifier {
  int _state = 0;

  int get value => _state;

  set(int index) {
    _state = index;
    notifyListeners();
  }
}
