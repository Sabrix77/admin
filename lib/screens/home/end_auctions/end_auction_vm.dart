import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/my_user.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_auth.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class EndAuctionViewModel extends BaseViewModel {
  List<Product>? products;
  String? errorMssage;
  List<String> sellersName = [];
  List<String?> winnersName = [];

  void getProductsByEndDate(DateTime selectedDate) async {
    String endDate =
        DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch.toString();
    try {
      products = await DBUtilsProducts.getProductsListByDate(endDate);
      await getNames();
    } catch (e) {
      errorMssage = 'error';
    }
    notifyListeners();
  }

  Future<void> getNames() async {
    sellersName = [];
    winnersName=[];
    for (int i = 0; i < products!.length; i++) {
      MyUser seller = await DBUtilsAuth.getUserData(products![i].sellerId);
      sellersName.add('${seller.firstName} ${seller.lastName}');

      ///  get winner name
      print('======\\${products![i].winnerID.length}');
      if (products![i].winnerID.length!=1) {

        MyUser winner = await DBUtilsAuth.getUserData(products![i].winnerID.last);

        winnersName.add('${winner.firstName} ${winner.lastName}');
      } else {
        winnersName.add(null);
      }
    }
  }

  void updateProduct(Product product, DateTime selectedDate) async {
    try {
      navigator!.showLoading();
      ///length 1 means that there is no bidders
      if(product.winnerID.length==1){
        product.auctionState = AuctionState.canceled.name;
      }else{
        product.auctionState = AuctionState.hasWinner.name;
      }
      await DBUtilsProducts.updateProductInFirestore(product);
      navigator!.hideDialog();
      navigator!.showMessage('Auction Successfully ended', 'Ok');
      getProductsByEndDate(selectedDate);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage('somethingWontWrong', 'ok');
    }
  }
}
