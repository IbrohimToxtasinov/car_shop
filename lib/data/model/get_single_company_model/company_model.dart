class CompanyModel {
  final int id;
  final String carModel;
  final int establishedYear;
  final String logo;
  final int averagePrice;
  final String description;
  final List<dynamic> carPics;

  CompanyModel({
    required this.id,
    required this.carModel,
    required this.establishedYear,
    required this.logo,
    required this.averagePrice,
    required this.description,
    required this.carPics,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json["id"] as int? ?? 0,
      carModel: json["car_model"] as String? ?? "",
      logo: json["logo"] as String? ?? "",
      establishedYear: json["established_year"] as int? ?? 0,
      averagePrice: json["average_price"] as int? ?? 0,
      description: json["description"] as String? ?? "",
      carPics: (json["car_pics"] as List<dynamic>?) ?? [],
    );
  }
}
