import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gobid_admin/model/my_user.dart';

class DBUtilsAuth {
  static Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  static Future<MyUser> getUserData(String uid) async {
    var user =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return MyUser.fromJson(user.data()!);
  }
}
