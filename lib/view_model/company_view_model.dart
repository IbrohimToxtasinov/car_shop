import 'package:car_shop/data/model/get_all_company_model/companies_model.dart';
import 'package:car_shop/data/model/get_single_company_model/company_model.dart';
import 'package:car_shop/data/repositories/app_repository.dart';
import 'package:flutter/foundation.dart';

class CompanyViewModel extends ChangeNotifier {
  CompanyViewModel({required AppRepository appRepository}) {
    _appRepository = appRepository;
  }

  late AppRepository _appRepository;

  bool isLoading = false;

  CompaniesModel? companies;
  CompanyModel? company;

  fetchCompaniesData() async {
    notify(true);
    companies = await _appRepository.getCompaniesData();
    notify(false);
  }

  fetchCompanyInfo({required int id}) async {
    notify(true);
    company = await _appRepository.getCompanyInfo(id: id);
    notify(false);
  }


  notify(bool value) {
    isLoading = value;
    notifyListeners();
  }
}