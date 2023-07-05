import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/shared/constants/enums.dart';

class DBUtilsProducts {
  static CollectionReference<Product> getProductCollectionRef() {
    return FirebaseFirestore.instance
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, options) =>
              Product.fromJson(snapshot.data()!),
          toFirestore: (product, options) => product.toJson(),
        );
  }

  static updateProductInFirestore(Product product) async {
    var ref = getProductCollectionRef();
    return await ref.doc(product.id).set(product);
  }

  static deleteProductFromFirestore(String productID) async {
    var ref = getProductCollectionRef();
    return await ref.doc(productID).delete();
  }

  static Future<List<Product>> getSelectedProductsList(
      {required String auctionState}) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot =
          await ref.where('auctionState', isEqualTo: auctionState).get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      print('==----==');

      return products;
    } catch (e) {
      print('==----==$e');
      rethrow;
    }
  }

  static Stream<QuerySnapshot<Product>> getStreamSelectedProductsList(
      {required String auctionState})  {
    try {
      var ref = getProductCollectionRef();
      Stream<QuerySnapshot<Product>> productsSnapshot =
       ref.where('auctionState', isEqualTo: auctionState).snapshots();

      return productsSnapshot;
    } catch (e) {
      print('==----==$e');
      rethrow;
    }
  }

  static Future<List<Product>> getNewWinnersProductsList() async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref
          .where('auctionState', isEqualTo: AuctionState.hasWinner.name)
          .get();

      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;

    } catch (e) {
      print('==----==$e');

      rethrow;
    }
  }

  static Future<List<Product>> getProductsListByDate(String date) async {
    try {
      var ref = getProductCollectionRef();
      print('=========DB=$date');
      QuerySnapshot<Product> productsSnapshot = await ref
          .where('auctionState', isEqualTo: AuctionState.confirmed.name)
          .where('endDate', isEqualTo: date)
          .get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      print('=========$e');
      rethrow;
    }
  }
}
