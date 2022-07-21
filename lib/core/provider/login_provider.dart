import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../ui/views/screens/splash/splash_login.dart';
import '../../utils/constant/app_string.dart';
import '../modal/login_post_data_modal.dart';
import '../services/login_service.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  LoginUsers? user;
  bool isLoading = true;

  loginData(context) async {
    isLoading = true;
    user = await loginPostData(
        loginEmailController.text, loginPasswordController.text, context);
    isLoading = false;
    notifyListeners();
  }

  onLogin(context) async {
    if (loginKey.currentState!.validate()) {
      await loginData(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SPlash(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        msg: AppString.failed,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
