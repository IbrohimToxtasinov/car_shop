import 'package:car_shop/view_model/company_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  final int id;
  const InfoPage({super.key, required this.id});

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
        title: const Text("Company"),
      ),
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              child: Consumer<CompanyViewModel>(
                  builder: (context, companyViewModel, child) {
                return companyViewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : (companyViewModel.companies == null
                        ? const Text("Hozircha malumot yo'q")
                        : Column(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              child: Stack(
                                  children: [
                                    PageView.builder(
                                      scrollDirection: Axis.horizontal,
                                      controller: _controller,
                                      itemCount:
                                          companyViewModel.company!.carPics.length,
                                      onPageChanged: _onChanged,
                                      itemBuilder: (context, int index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(companyViewModel.company!.carPics[index]), fit: BoxFit.cover)
                                          ),
                                        );
                                      },
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
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 30),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: (index == _currentPage)
                                                  ? Colors.blue
                                                  : Colors.blue.withOpacity(0.5)),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        ));
              }))),
    );
  }
}
