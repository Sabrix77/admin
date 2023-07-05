import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/screens/home/exist_list/exist_list_navigator.dart';
import 'package:gobid_admin/screens/home/exist_list/exist_list_vm.dart';
import 'package:gobid_admin/shared/components/utilis.dart' as utils;
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class ExistProductsList extends StatefulWidget {
  const ExistProductsList({Key? key}) : super(key: key);

  @override
  _ExistProductsListState createState() => _ExistProductsListState();
}

class _ExistProductsListState
    extends BaseView<ExistProductsList, ExistListViewModel>
    implements ExistListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.getAllConfirmedProducts();
  }

  @override
  ExistListViewModel initViewModel() {
    return ExistListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Consumer<ExistListViewModel>(
        builder: (_, existVM, __) {
          if (existVM.products == null) {
            // change to shimmer
            return const Center(child: CircularProgressIndicator());
          }
          if (existVM.products!.isEmpty) {
            return Center(child: Image.asset('assets/images/empty-confirmed.png'));
          }
          if (existVM.errorMessage != null) {
            return const Center(child: Text(AppStrings.somethingWontWrong));
          }
          return ListView.builder(
              itemCount: existVM.products!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              existVM.products![index].imgUrl,
                              fit: BoxFit.cover,
                              width: 120,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      existVM.products![index].title,
                                      maxLines: 5,
                                      style: const TextStyle(fontSize: 20),
                                    ),

                                    const SizedBox(height: 8),
                                    //Text(endDate.toString().substring(0,10)),
                                    const SizedBox(height: 8),
                                    Text(
                                        '${existVM.products![index].biggestBid.last.toString()} LE',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Text(existVM.products![index].description,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              deleteProduct(existVM.products![index].id);
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.delete),
                                SizedBox(width: 4),
                                Text('DELETE', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  void deleteProduct(String productID) {
    utils.showMessage(
        context, 'Are you sure you want to delete this item?', 'Delete',
        (context) {
      viewModel.deleteProduct(productID);
      viewModel.navigator!.hideDialog();
    },
        negativeBtnTxt: 'Cancel',
        negativeBtnAct: (context) => viewModel.navigator!.hideDialog());
  }
  @override
  void hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
