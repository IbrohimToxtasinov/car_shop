import 'package:car_shop/data/model/get_all_company_model/data.dart';

class CompaniesModel {
  final List<Data> data;

  CompaniesModel({required this.data});

  factory CompaniesModel.fromJson(Map<String, dynamic> json) {
    return CompaniesModel(
      data: (json["data"] as List).map((e) => Data.fromJson(e)).toList(),
    );
  }
}