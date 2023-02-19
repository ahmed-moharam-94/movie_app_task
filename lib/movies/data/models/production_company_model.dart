import 'package:movies_app_task/movies/domain/entities/production_company.dart';

class ProductionCompanyModel extends ProductionCompany {
  const ProductionCompanyModel({required super.id, required super.name});

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(id: json['id'], name: json['name']);
  }
}
