import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/my_user.dart';

abstract class LoginNavigator implements BaseNavigator {
  void navigateToHome(MyUser user);
}
