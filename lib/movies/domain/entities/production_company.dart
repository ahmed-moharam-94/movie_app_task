import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable {
  final int id;
  final String name;

  const ProductionCompany({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}
