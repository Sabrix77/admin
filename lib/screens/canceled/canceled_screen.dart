import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/screens/canceled/canceled_navigator.dart';
import 'package:gobid_admin/screens/canceled/canceled_vm.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({Key? key}) : super(key: key);

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends BaseView<CanceledScreen, CanceledViewModel>
    implements CanceledNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  CanceledViewModel initViewModel() {
    return CanceledViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getAllCanceledProducts();
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'All Canceled Auctions',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height: 20),
            ChangeNotifierProvider(
              create: (context) => viewModel,
              child: Expanded(
                child: Consumer<CanceledViewModel>(
                  builder: (_, canceledVM, __) {
                    if (canceledVM.products == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (canceledVM.products!.isEmpty) {
                      return Center(child: Image.asset('assets/images/empty-canceled.png'));

                    }
                    if (canceledVM.errorMsg != null) {
                      return const Center(
                        child: Text(AppStrings.somethingWontWrong),
                      );
                    }
                    return ListView.separated(
                      itemCount: canceledVM.products!.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              SizedBox(
                                height:130,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Image.network(
                                      canceledVM.products![index].imgUrl,
                                      fit: BoxFit.cover,
                                      width: 120,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 4),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              canceledVM.products![index].title,
                                              maxLines: 4,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                                '${canceledVM.products![index].biggestBid.last.toString()} LE',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green
                                                )),
                                          ],
                                        ) ,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,

                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      '${canceledVM.products![index].description}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            showCancelConfirmation(
                                                canceledVM
                                                    .products![index].id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.redAccent),
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCancelConfirmation(String productID) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Are you sure you want to delete this Auction Permanently?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.deleteProduct(productID);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Delete')),
            ],
          );
        });
  }

  @override
  void hideDialog() {
    // TODO: implement hideDialog
    Navigator.of(context, rootNavigator: true).pop();
  }
}
