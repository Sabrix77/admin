import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/my_user.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_auth.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/screens/winnig_products/new_winners/new_winners_navigator.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class NewWinnersViewModel extends BaseViewModel<NewWinnersNavigator> {
  List<Product>? products;
  String? errorMsg;
  List<String> sellersName = [];
  List<String> winnersName = [];

  void getNewWinners() async {
    try {
      products = await DBUtilsProducts.getSelectedProductsList(auctionState: AuctionState.hasWinner.name);
      print('====>>${products!.length}');
     await getNames();
    } catch (e) {
      errorMsg = AppStrings.somethingWontWrong;
    }
    notifyListeners();
  }

  Future<void> getNames() async {
    for (int i = 0; i < products!.length; i++) {
      MyUser seller = await DBUtilsAuth.getUserData(products![i].sellerId);
      sellersName.add('${seller.firstName} ${seller.lastName}');

      ///  get winner name
      MyUser winner = await DBUtilsAuth.getUserData(products![i].winnerID.last);
      winnersName.add('${winner.firstName} ${winner.lastName}');

    }
  }

 Future<void> updateAuctionStateToDelivered(Product product)async{
    try{
      product.auctionState=AuctionState.delivered.name;
      await DBUtilsProducts.updateProductInFirestore(product);
      getNewWinners();
    }catch(e){
      print(e);
    }
  }

  Future<void> updateAuctionStateToCanceled(Product product)async{
    try{
      product.auctionState=AuctionState.canceled.name;
      await DBUtilsProducts.updateProductInFirestore(product);
      getNewWinners();
    }catch(e){
      print(e);
    }
  }

}
