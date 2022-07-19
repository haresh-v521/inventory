import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/api_url.dart';
import '../modal/profile_update_modal.dart';

var dio = Dio();

Future profileUpdate(String name, String email, int id) async {
  var parameters = {
    "name": name,
    "email": email,
  };
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Response res = await dio.put(
    "${ApiUrl.baseUrl}profileUpdate/$id",
    data: jsonEncode(parameters),
    options: Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    ),
  );
  if (res.statusCode == 200) {
    return ProfileUpdate.fromJson(res.data);
  } else if (res.statusCode == 302) {
    throw Exception('SomeThing went Wrong');
  } else {
    throw Exception('failed to create product');
  }
}
