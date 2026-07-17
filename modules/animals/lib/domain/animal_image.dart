import 'package:equatable/equatable.dart';

class AnimalImage extends Equatable {
  const AnimalImage({required this.id, this.small, this.medium, this.large, this.isPrimary = false, this.filename});

  final int? id;
  final String? small;
  final String? medium;
  final String? large;
  final bool isPrimary;
  final String? filename;

  /// Лучший доступный превью-URL (мелкий → средний → крупный).
  String? get thumb => small ?? medium ?? large;

  @override
  List<Object?> get props => [id, small, medium, large, isPrimary, filename];
}
