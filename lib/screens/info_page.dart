import 'package:car_shop/view_model/company_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  final int id;
  final String companyName;
  const InfoPage({super.key, required this.id, required this.companyName});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  @override
  void initState() {
    Future.microtask(
        () => context.read<CompanyViewModel>().fetchCompanyInfo(id: widget.id));
    super.initState();
  }

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.companyName} Company"),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 0),
              child: Consumer<CompanyViewModel>(
                  builder: (context, companyViewModel, child) {
                return companyViewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : (companyViewModel.companies == null
                        ? const Text("Hozircha malumot yo'q")
                        : Column(
                            children: [
                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: _controller,
                                      itemCount: companyViewModel
                                          .company!.carPics.length,
                                      onPageChanged: _onChanged,
                                      itemBuilder: (context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      companyViewModel.company!
                                                          .carPics[index]),
                                                  fit: BoxFit.cover)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    companyViewModel.company!.carPics.length,
                                    (int index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 10,
                                    width: (index == _currentPage) ? 15 : 10,
                                    margin: const EdgeInsets.only(
                                        top: 15, left: 5, right: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: (index == _currentPage)
                                            ? Colors.blue
                                            : Colors.blue.withOpacity(0.5)),
                                  );
                                }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 20, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Image.network(
                                    companyViewModel.company!.logo,
                                    width: 150,
                                    height: 75,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Avarage Price :${companyViewModel.company!.averagePrice}\$",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16, ),
                                      ),
                                      Text(
                                        "Established Year : ${companyViewModel
                                            .company!.establishedYear}",
                                        style: const TextStyle(
                                          
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Text(
                                  companyViewModel.company!.description,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ));
              }))),
    );
  }
}
