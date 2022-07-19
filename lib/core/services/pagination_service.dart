import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/api_url.dart';
import '../modal/list_product_modal.dart';

var dio = Dio();

Future getProduct(int page) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  try {
    Response res = await dio.get(
      "${ApiUrl.baseUrl}products?page=$page",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    if (res.statusCode == 200) {
      return Listing.fromJson(res.data);
    }
  } catch (e) {
    return;
  }
}
