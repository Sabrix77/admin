import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class WaitingListVieModel extends BaseViewModel {
  List<Product>? products;

  String? errorMessage;

  void getWaitedProducts() async {
    try {
      products = await DBUtilsProducts.getSelectedProductsList(
          auctionState: AuctionState.waitingConfirmation.name);
    } catch (e) {
      errorMessage = AppStrings.somethingWontWrong;
    }
    notifyListeners();
  }

  void updateProduct(Product product) async {
    try {
      navigator!.showLoading();
      product.auctionState = AuctionState.confirmed.name;
      await DBUtilsProducts.updateProductInFirestore(product);
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.successfullyUploaded, AppStrings.ok);
      getWaitedProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }

  void deleteProduct(String productID) async {
    try {
      navigator!.showLoading();
      await DBUtilsProducts.deleteProductFromFirestore(productID);
      navigator!.hideDialog();

      navigator!.showMessage(AppStrings.successfullyDeleted, AppStrings.ok);

      ///to rebuild screen after item is deleted
      getWaitedProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }
}
