import 'package:acits_flutter/ui/screen/search_screen/search_shelter_screen.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';

/// Роут поиска / выбора приюта
class SearchShelterScreenRoute extends MaterialPageRoute<ShelterShortSerializers> {
  SearchShelterScreenRoute() : super(builder: (_) => const SearchShelterScreen());
}
