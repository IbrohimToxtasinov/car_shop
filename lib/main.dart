import 'package:car_shop/data/api_sevice/api_service.dart';
import 'package:car_shop/data/repositories/app_repository.dart';
import 'package:car_shop/screens/home_page.dart';
import 'package:car_shop/view_model/company_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  AppRepository appRepository = AppRepository(apiService: ApiService());
  CompanyViewModel companyViewModel = CompanyViewModel(appRepository: appRepository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => companyViewModel),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
