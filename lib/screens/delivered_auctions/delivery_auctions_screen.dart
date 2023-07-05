import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/screens/delivered_auctions/delivery_auctions_navigator.dart';
import 'package:gobid_admin/screens/delivered_auctions/delivery_auctions_vm.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:provider/provider.dart';

class DeliveredAuctions extends StatefulWidget {
  const DeliveredAuctions({Key? key}) : super(key: key);

  @override
  _DeliveredAuctionsState createState() => _DeliveredAuctionsState();
}

class _DeliveredAuctionsState extends BaseView<DeliveredAuctions, DeliveredAuctionsViewModel>
    implements DeliveredAuctionsNavigator {
  @override


  @override
  DeliveredAuctionsViewModel initViewModel() {
    return DeliveredAuctionsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getAllDeliveredProducts();
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Delivered Auctions',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 20),
          ChangeNotifierProvider(
            create: (context) => viewModel,
            child: Expanded(
              child: Consumer<DeliveredAuctionsViewModel>(
                builder: (_, deliveredVM, __) {
                  if (deliveredVM.products == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (deliveredVM.products!.isEmpty) {
                    return Center(child: Image.asset('assets/images/empty-delivered.png'));

                  }
                  if (deliveredVM.errorMsg != null) {
                    return const Center(
                      child: Text(AppStrings.somethingWontWrong),
                    );
                  }
                  DateTime endDate;
                  return ListView.separated(
                    itemCount: deliveredVM.products!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      endDate = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(deliveredVM.products![index].endDate));
                      return Card(
                        elevation: 8,
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.network(
                                deliveredVM.products![index].imgUrl,
                                fit: BoxFit.cover,
                                width: 120,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 4),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          deliveredVM.products![index].title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),
                                        //Text(endDate.toString().substring(0,10)),
                                        const SizedBox(height: 8),
                                        Text(
                                            '${deliveredVM.products![index].biggestBid.last.toString()} LE',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height:8),
                                        Text(
                                            '${deliveredVM.products![index].description}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
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
    );
  }
}
