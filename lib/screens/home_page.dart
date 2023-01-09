import 'package:car_shop/screens/info_page.dart';
import 'package:car_shop/view_model/company_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<CompanyViewModel>().fetchCompaniesData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Companies"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: double.infinity,
        margin: const EdgeInsets.all(15),
        child: Consumer<CompanyViewModel>(
            builder: (context, companiesViewModel, child) {
          return companiesViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : (companiesViewModel.companies == null
                  ? const Text("Hozircha malumot yo'q")
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: companiesViewModel.companies!.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => InfoPage(id: companiesViewModel.companies!.data[index].id, companyName: companiesViewModel.companies!.data[index].carModel,)));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Center(
                                  child: Image(
                                image: NetworkImage(companiesViewModel
                                    .companies!.data[index].logo),
                                width: 150,
                              )),
                            ),
                          ),
                        );
                      },
                    ));
        }),
      ),
    );
  }
}
