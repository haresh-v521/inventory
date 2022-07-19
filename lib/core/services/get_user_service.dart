import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';
import '../modal/user_profile_modal.dart';

var dio = Dio();

Future getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  try {
    Response res = await dio.get(
      "${ApiUrl.baseUrl}getUserProfile",
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      ),
    );
    if (res.statusCode == 200) {
      return UserProfile.fromJson(res.data);
    }
  } catch (e) {
    return;
  }
}
