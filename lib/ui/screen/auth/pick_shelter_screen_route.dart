import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/auth/pick_shelter_screen.dart';
import 'package:flutter/material.dart';

class PickShelterScreenRoute extends MaterialPageRoute<ShelterShortSerializers> {
  PickShelterScreenRoute({PaginatedShelterShortSerializersList? shelterList})
      : super(builder: (_) => PickShelterScreen(shelterList: shelterList));
}
