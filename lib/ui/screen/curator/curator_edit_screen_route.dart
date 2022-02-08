import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/curator/curator_edit_screen.dart';
import 'package:flutter/material.dart';

class CuratorEditScreenRoute extends MaterialPageRoute<Curator?> {
  CuratorEditScreenRoute({int? curatorId})
      : super(builder: (_) => CuratorEditScreen(curatorId: curatorId));
}
