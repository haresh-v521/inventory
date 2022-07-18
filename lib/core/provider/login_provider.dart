import 'package:flutter/material.dart';

import '../modal/login_post_data_modal.dart';
import '../services/http_service.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  LoginUsers? user;
  bool isLoading = true;

  loginData(context) async {
    isLoading = true;
    user = await loginPostData(
      loginEmailController.text,
      loginPasswordController.text,
      context,
    );
    isLoading = false;
    notifyListeners();
  }
}
