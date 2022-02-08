import 'package:acits_flutter/export.dart';

extension CuratorX on Curator {
  String? get fullName {
    return '$firstName $lastName';
  }
}
