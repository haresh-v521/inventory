import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/api_url.dart';
import '../modal/list_product_modal.dart';

var dio = Dio();

Future getProduct(int page, context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  try {
    Response res = await dio
        .get(
      "${ApiUrl.baseUrl}products?page=$page",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
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
    if (res.statusCode == 200) {
      return Listing.fromJson(res.data);
    }
  } catch (e) {
    return;
  }
}
