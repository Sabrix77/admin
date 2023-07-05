import 'package:firebase_auth/firebase_auth.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/my_user.dart';
import 'package:gobid_admin/network/remote/db_utils_auth.dart';
import 'package:gobid_admin/screens/login/login_navigator.dart';
import 'package:gobid_admin/shared/constants/app_strings.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  loginWithEmailAndPassword(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await DBUtilsAuth.loginWithEmailAndPassword(email, password);
      MyUser user = await DBUtilsAuth.getUserData(credential.user!.uid);

      navigator!.hideDialog();
      if (user.isAdmin) {
        //does we will need to pass user to provider ?

        navigator!.navigateToHome(user);
      } else {
        navigator!.showMessage(AppStrings.adminNotValid, AppStrings.ok);
      }
    } on FirebaseAuthException catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.userNotValid, AppStrings.ok);
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }
}
