import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';
import '../modal/register_post_data_modal.dart';

var dio = Dio();

Future registerPostData(String name, String email, int password, String dob,
    String gender, String passwordConfirm, context) async {
  var parameters = {
    "name": name,
    "email": email,
    "password": password,
    "birth_date": dob,
    "gender": gender,
    "password_confirmation": passwordConfirm,
  };

  try {
    Response res = await dio
        .post(
      "${ApiUrl.baseUrl}register",
      data: FormData.fromMap(parameters),
      options: Options(
        headers: {HttpHeaders.authorizationHeader: "Bearer token"},
      ),
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
      await preferences.setString('email', email);
      await preferences.setInt('password', password);
      await preferences.setBool('status', responseJson['status']);
      return PostData.fromJson(res.data);
    } else {
      return "Something Wrong";
    }
  } catch (e) {
    return;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
