import 'package:acits_flutter/ui/screen/search_screen/search_drug_screen.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';

/// Роут поиска / выбора животного
class SearchDrugScreenRoute extends MaterialPageRoute<ShelterDrug> {
  SearchDrugScreenRoute() : super(builder: (_) => const SearchDrugScreen());
}
