import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/chat.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/screens/support/messages/messages_screen.dart';
import 'package:gobid_admin/screens/support/support_screen.dart';
import 'package:gobid_admin/screens/winnig_products/new_winners/new_winners_navigator.dart';
import 'package:gobid_admin/screens/winnig_products/new_winners/new_winners_vm.dart';
import 'package:gobid_admin/shared/components/product_card.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:gobid_admin/shared/constants/enums.dart';
import 'package:provider/provider.dart';
import 'package:gobid_admin/shared/components/utilis.dart' as utils;

class NewWinnersScreen extends StatefulWidget {
  const NewWinnersScreen({Key? key}) : super(key: key);

  @override
  State<NewWinnersScreen> createState() => _NewWinnersScreenState();
}

class _NewWinnersScreenState
    extends BaseView<NewWinnersScreen, NewWinnersViewModel>
    implements NewWinnersNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  NewWinnersViewModel initViewModel() {
    return NewWinnersViewModel();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getNewWinners();
    return Scaffold(
      appBar: AppBar(
        title: Text('Winners'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<NewWinnersViewModel>(
          builder: (_, newWinnersNM, __) {
            if (newWinnersNM.products == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (newWinnersNM.products!.isEmpty) {
              return Center(
                  child: Image.asset('assets/images/empty-winners.png'));
            }
            if (newWinnersNM.errorMsg != null) {
              return const Center(
                child: Text(AppStrings.somethingWontWrong),
              );
            }
            return ListView.builder(
              itemCount: newWinnersNM.products!.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.grey[300] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 240,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 230,
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 135),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 4),
                                              Text(
                                                newWinnersNM
                                                    .products![index].title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Initial Price : ${newWinnersNM.products![index].price.toString()} LE',
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Biggest Price : ${newWinnersNM.products![index].biggestBid.last.toString()} LE',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2!
                                                        .copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      'Seller: ${newWinnersNM.sellersName[index]}',
                                                      style: TextStyle(
                                                          fontStyle: FontStyle
                                                              .italic)),
                                                  Row(
                                                    children: [
                                                      Text('winner: ',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic)),
                                                      Expanded(
                                                        child: Text(
                                                            newWinnersNM
                                                                    .winnersName[
                                                                index],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Visibility(
                                                      visible: newWinnersNM
                                                          .products![index]
                                                          .paymentMethod
                                                          .isNotEmpty,
                                                      replacement: Text(
                                                          'Payment Not confirmed',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Colors
                                                                  .redAccent)),
                                                      child: Text(
                                                          'Payment Method: ${newWinnersNM.products![index].paymentMethod}',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic))),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .greenAccent,
                                                            foregroundColor:
                                                                Colors.black),
                                                    onPressed: () {
                                                      showDeliverConfirmation(
                                                          newWinnersNM
                                                                  .products![
                                                              index]);
                                                    },
                                                    child:
                                                        const Text('Deliver'),
                                                  ),
                                                  SizedBox(width: 10),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Chat chat = Chat(
                                                        id: newWinnersNM
                                                            .products![index]
                                                            .winnerID.last,
                                                        name: newWinnersNM
                                                            .winnersName[index],
                                                      );
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pushNamed(
                                                              MessagesScreen
                                                                  .routeName,
                                                              arguments: chat);
                                                    },
                                                    child: Text('Contact'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          right: 10,
                          top: 25,
                          child: InkWell(
                            onTap: () {
                              showCancelConfirmation(
                                  newWinnersNM.products![index]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 15,
                          child: SizedBox(
                            width: 120,
                            // color: Colors.red,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage(
                                placeholder: const AssetImage(
                                    'assets/images/Loading_icon.gif'),
                                image: NetworkImage(
                                    newWinnersNM.products![index].imgUrl),
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
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
    );
  }

  void showDeliverConfirmation(Product product) {
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            content: Text(
                'Are you sure that you want to make it as a delivered auction?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.updateAuctionStateToDelivered(product).then(
                        (value) =>
                            Navigator.of(context, rootNavigator: true).pop());
                  },
                  child: Text('Confirm')),
            ],
          );
        });
  }

  void showCancelConfirmation(Product product) {
    showDialog(
        context: context,
        builder: (contex) {
          return AlertDialog(
            content: Text(
                'Didn\'t you get agreement to winner? \nYou Can Cancel this auction.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Get Back'),
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.updateAuctionStateToCanceled(product).then(
                        (value) =>
                            Navigator.of(context, rootNavigator: true).pop());
                  },
                  child: Text('Yes Cancel')),
            ],
          );
        });
  }
}
