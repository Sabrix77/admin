import 'package:flutter/cupertino.dart';
import 'package:gobid_admin/model/my_user.dart';

class AuthProvider extends ChangeNotifier {
  MyUser? myUser;
  void createUser(MyUser user) {
    myUser = user;
  }
}
