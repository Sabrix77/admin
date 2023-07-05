import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/screens/delivered_auctions//delivery_auctions_navigator.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class DeliveredAuctionsViewModel extends BaseViewModel<DeliveredAuctionsNavigator> {
  List<Product>? products;
  String? errorMsg;

  void getAllDeliveredProducts() async {
    try {
     products= await DBUtilsProducts.getSelectedProductsList(
          auctionState: AuctionState.delivered.name);
    } catch (e) {
      errorMsg = '';
    }
    notifyListeners();
  }
}
