import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/api_url.dart';
import '../modal/login_post_data_modal.dart';

var dio = Dio();

Future loginPostData(String email, String password, context) async {
  var parameters = {
    "email": email,
    "password": password,
  };

  try {
    Response res = await dio
        .post(
      "${ApiUrl.baseUrl}login",
      data: FormData.fromMap(parameters),
    )
        .catchError((e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(e.message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();

    final responseJson = res.data;
    if (responseJson['status'] == true) {
      await preferences.setString('token', responseJson['token']);
      await preferences.setBool('status', responseJson['status']);
      return LoginUsers.fromJson(res.data);
    } else {
      Fluttertoast.showToast(
        msg: "password is InCorrect",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    return;
  }
}
