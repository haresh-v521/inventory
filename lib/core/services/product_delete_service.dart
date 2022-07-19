import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';

var dio = Dio();

Future productDelete(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  await dio.delete("${ApiUrl.baseUrl}products/$id",
      options: Options(followRedirects: true, headers: {
        "Authorization": "Bearer $token",
      }));
}
