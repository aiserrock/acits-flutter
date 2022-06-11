import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_animal_screen.dart';

/// Роут поиска / выбора животного
class SearchAnimalScreenRoute extends MaterialPageRoute<AnimalRead> {
  SearchAnimalScreenRoute() : super(builder: (_) => const SearchAnimalScreen());
}
