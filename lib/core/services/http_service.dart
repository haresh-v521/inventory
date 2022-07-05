import 'dart:io';
import 'package:dio/dio.dart';
import 'package:login_figma/core/modal/add_product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';
import '../modal/login_post_data_modal.dart';
import '../modal/register_post_data_modal.dart';
import '../modal/user_profile_modal.dart';

String token =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiMTUyN2MwYjg0YjBlZDQyY2JiNmIyYjI2NmQxNmY2MDRjZGY1YmFkMmU2Y2ZhNmJjYWEwMTRhZTM1ZTMzNzJmMzkyMWMxYjMzZjM4NWU0YTYiLCJpYXQiOjE2NTcwMTExOTkuNzI3MzU4LCJuYmYiOjE2NTcwMTExOTkuNzI3MzYyLCJleHAiOjE2ODg1NDcxOTkuNzI0NzAyLCJzdWIiOiIzNTIiLCJzY29wZXMiOltdfQ.iWgIO15F05xjNvveV8FGROUjLpkCs8CLpZI9NLDnFgxc62ZLP_If3C0eL4jS4uD39lpAVpIEc0CGut4wxBebG6n6tKJeJReESdiq2PK4vHCqH_AwXy1A7hl8tq37dx-Qx5ZD9JjfSHYnQUnt76HC8iXBbraUoJ-k-Nn0e5P8wYW9Ql80LY1fliFR7Vt8MlsGpSAiApu97RrpdbPnrf-wHsN-VPhJS6I3-kvDrXAxXC_uiw9n7ojtSt_DFh5kZVg39b3pk6e0_bVMGQRykKSg8OyKfQJ2wZjjTqoEsacCU9tMwZHttjsvRwzdp0gw_izx8qMtKUix8X9ehrnE_a6TzgYmsp9Wilcshx6NqWEBLFmmdK3FarTaEqyHatdzqUbayzqAwdcQiPXkrj8-aYb2A42gEJxAHLQNIPem4KWX0J_fA4KwndMG3XQ7w2Yf_3cu-NkQh_zUTyZWod2qx_7FkDJ6kx9vdyzhRGC9eNSlGEgRlEndRAJm1ph8pRoRwOUeFOgoTnFj2bJERQ6MdN0KO8gvVvCXyRBAamYyeBbQXsmzOH1DZzqVilsxLKC2grnz9FVRR1BKBS34rzekSHOD2X5Pqh975U85aiIHn6ofqzhEx56LzogBWkr7wHeShOci8S-ufMpG6HrokjOvqNLKhR_sG2L7Jukk_1WhlVjLc9E";

setTokenToSF() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setString("token", token);
}

Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

var dio = Dio();

Future registerPostData(
  String name,
  String email,
  String password,
  String dob,
  String gender,
  String passwordConfirm,
) async {
  var parameters = {
    "name": name,
    "email": email,
    "password": password,
    "birth_date": dob,
    "gender": gender,
    "password_confirmation": passwordConfirm,
  };

  Response res = await dio.post(
    "${ApiUrl.baseUrl}register",
    data: FormData.fromMap(parameters),
  );
  if (res.statusCode == 200) {
    return PostData.fromJson(res.data);
  } else {
    throw Exception('Failed to create Post.');
  }
}

Future loginPostData(String email, String password) async {
  var parameters = {
    "email": email,
    "password": password,
  };

  Response res = await dio.post(
    "${ApiUrl.baseUrl}login",
    data: FormData.fromMap(parameters),
  );
  if (res.statusCode == 200) {
    return LoginUsers.fromJson(res.data);
  } else {
    throw Exception('Failed to create Post.');
  }
}

Future getUser() async {
  Response res = await dio.get("${ApiUrl.baseUrl}getUserProfile",
      options: Options(headers: {
        "Authorization": 'Bearer $token',
      }));
  if (res.statusCode == 200) {
    return UserProfile.fromJson(res.data);
  } else {
    throw Exception('Failed to fetch User.');
  }
}

Future addProducts(String name, mrp, selling, description,File image) async {
  var parameters = {
    "name": name,
    "mrp": mrp,
    "selling": selling,
    "description": description,
    "image" : image,
  };

  Response res = await dio.post(
    "${ApiUrl.baseUrl}products",
    data: FormData.fromMap(parameters),
  );
  if (res.statusCode == 200) {
    return AddProduct.fromJson(res.data);
  } else {
    throw Exception('Failed to create Post.');
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
