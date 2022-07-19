import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';
import '../modal/product_update_modal.dart';

var dio = Dio();

Future productUpdate(
    String name, String mrp, String selling, String description, int id) async {
  var parameters = {
    "name": name,
    "mrp": mrp,
    "selling": selling,
    "description": description,
  };

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  Response res = await dio.put("${ApiUrl.baseUrl}products/$id",
      data: jsonEncode(parameters),
      options: Options(followRedirects: true, headers: {
        "Authorization": "Bearer $token",
      }));

  if (res.statusCode == 200) {
    return UpdateProduct.fromJson(res.data);
  } else if (res.statusCode == 302) {
    throw Exception('SomeThing went Wrong');
  } else {
    throw Exception('failed to create product');
  }
}
