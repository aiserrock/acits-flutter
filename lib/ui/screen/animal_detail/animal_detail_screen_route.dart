import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/screen/animal_detail/animal_detail_screen.dart';

class AnimalDetailScreenRoute extends MaterialPageRoute<bool> {
  AnimalDetailScreenRoute({required int id}) : super(builder: (_) => AnimalDetailScreen(id: id));
}
