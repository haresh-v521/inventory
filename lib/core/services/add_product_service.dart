import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/api_url.dart';
import '../modal/add_product_modal.dart';

var dio = Dio();

Future addProducts(
    String name, int mrp, int selling, String description, File image) async {
  String fileName = image.path.split('/').last;
  var parameters = {
    "name": name,
    "mrp": mrp,
    "selling": selling,
    "description": description,
    "image": await MultipartFile.fromFile(image.path, filename: fileName),
  };
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  Response res = await dio.post("${ApiUrl.baseUrl}products",
      data: FormData.fromMap(parameters),
      options: Options(followRedirects: true, headers: {
        "Authorization": "Bearer $token",
      }));
  if (res.statusCode == 200) {
    return Add.fromJson(res.data);
  } else if (res.statusCode == 302) {
    throw Exception('SomeThing went Wrong');
  } else {
    throw Exception('failed to create product');
  }
}
