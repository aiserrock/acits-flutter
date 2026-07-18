import 'package:equatable/equatable.dart';

class Shelter extends Equatable {
  const Shelter({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
