import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class CanceledViewModel extends BaseViewModel {
  List<Product>? products;
  String? errorMsg;

  void getAllCanceledProducts() async {
    try {
      products = await DBUtilsProducts.getSelectedProductsList(
          auctionState: AuctionState.canceled.name);
    } catch (e) {
      errorMsg = '';
    }
    notifyListeners();
  }

  void deleteProduct(String productID) async {
    try {
      navigator!.showLoading();
      await DBUtilsProducts.deleteProductFromFirestore(productID);
      navigator!.hideDialog();

      navigator!.showMessage(AppStrings.successfullyDeleted, AppStrings.ok);

      ///to rebuild screen after item is deleted
      getAllCanceledProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }
}
