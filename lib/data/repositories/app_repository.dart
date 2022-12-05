import 'package:car_shop/data/api_sevice/api_service.dart';
import 'package:car_shop/data/model/get_all_company_model/companies_model.dart';
import 'package:car_shop/data/model/get_single_company_model/company_model.dart';

class AppRepository {
  AppRepository({
    required ApiService apiService,
  }) {
    _apiService = apiService;
  }

  late ApiService _apiService;

  Future<CompaniesModel> getCompaniesData() => _apiService.getAllCompany();
  Future<CompanyModel> getCompanyInfo({required int id}) => _apiService.getSingleCompany(id: id);
}
