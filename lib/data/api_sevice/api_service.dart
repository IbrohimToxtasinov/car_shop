import 'package:car_shop/data/model/get_all_company_model/companies_model.dart';
import 'package:car_shop/data/model/get_single_company_model/company_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future<CompaniesModel> getAllCompany() async {
    try {
      Response response = await http
          .get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies"));
      if (response.statusCode >= 200) {
        return CompaniesModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<CompanyModel> getSingleCompany({required int id}) async {
    try {
      Response response = await http
          .get(Uri.parse("https://easyenglishuzb.free.mockoapp.net/companies/$id"));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return CompanyModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}