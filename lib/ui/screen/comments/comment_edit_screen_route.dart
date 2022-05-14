import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/comments/comment_edit_screen.dart';
import 'package:flutter/material.dart';

class CommentEditScreenRoute extends MaterialPageRoute<AnimalNote?> {
  CommentEditScreenRoute({
    required int animalId,
    AnimalNote? comment,
  }) : super(
          builder: (_) => CommentEditScreen(
            animalId: animalId,
            comment: comment,
          ),
        );
}
