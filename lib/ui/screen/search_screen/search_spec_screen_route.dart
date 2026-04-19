import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_spec_screen.dart';
import 'package:flutter/material.dart';

class SearchScreenRoute extends MaterialPageRoute<Species> {
  SearchScreenRoute({Species? parentSearch})
    : super(builder: (_) => SearchScreen(parentSearch: parentSearch));
}
