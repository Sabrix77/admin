import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/screens/home/end_auctions/end_auction_navigator.dart';
import 'package:gobid_admin/screens/home/end_auctions/end_auction_vm.dart';
import 'package:gobid_admin/shared/components/product_card.dart';
import 'package:provider/provider.dart';

class EndAuctionsScreen extends StatefulWidget {
  const EndAuctionsScreen({Key? key}) : super(key: key);

  @override
  _EndAuctionsScreenState createState() => _EndAuctionsScreenState();
}

class _EndAuctionsScreenState
    extends BaseView<EndAuctionsScreen, EndAuctionViewModel>
    implements EndAuctionNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  EndAuctionViewModel initViewModel() {
    return EndAuctionViewModel();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    viewModel.getProductsByEndDate(selectedDate);
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Column(
          children: [
            const SizedBox(height: 10),
            CalendarTimeline(
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(const Duration(days: 30)),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              onDateSelected: (date) {
                viewModel.getProductsByEndDate(date);
              },
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: const Color(0xFF333A47),
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
            const SizedBox(height: 20),
            Consumer<EndAuctionViewModel>(builder: (_, endAuctionsVm, __) {
              if (endAuctionsVm.products == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (endAuctionsVm.products!.isEmpty) {
                return  Center(
                  child: Column(
                    children: [
                      // SizedBox(height: 20),
                    //  Text('No auctions for today'),
                      Image.asset('assets/images/end_auction.png'),
                    ],
                  ),
                );
              }
              if (endAuctionsVm.errorMssage != null) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: endAuctionsVm.products!.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: endAuctionsVm.products![index],
                      sellerName: endAuctionsVm.sellersName[index],
                      winnerName: endAuctionsVm.winnersName[index],
                      onPressed: () {
                        viewModel.updateProduct(endAuctionsVm.products![index],selectedDate);
                      },
                      btnTxt: 'End Auction',

                    );
                  },
                ),
              );
            })
          ],
        ),

    );
  }
  @override
  void hideDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
