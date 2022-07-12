import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:login_figma/core/modal/add_product.dart';
import 'package:login_figma/core/modal/list_product_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/api_url.dart';
import '../modal/login_post_data_modal.dart';
import '../modal/register_post_data_modal.dart';
import '../modal/user_profile_modal.dart';

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

  Response res = await dio.post("${ApiUrl.baseUrl}register",
      data: FormData.fromMap(parameters),
      options:
          Options(headers: {HttpHeaders.authorizationHeader: "Bearer token"}));
  if (res.statusCode == 200) {
    final responseJson = res.data;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', responseJson['token']);
    await preferences.setString('email', email);
    await preferences.setString('password', password);
    return PostData.fromJson(res.data);
  } else {
    throw Exception("Can't Register");
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
    final responseJson = res.data;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', responseJson['token']);

    return LoginUsers.fromJson(res.data);
  } else {
    throw Exception('Failed to login');
  }
}

Future getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Response res = await dio.get(
    "${ApiUrl.baseUrl}getUserProfile",
    options: Options(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
        HttpHeaders.contentTypeHeader: "application/json"
      },
    ),
  );
  if (res.statusCode == 200) {
    return UserProfile.fromJson(res.data);
  } else {
    throw Exception('Failed to fetch User.');
  }
}

Future getProduct(int page) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

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
  } else {
    throw Exception('Failed to fetch User.');
  }
}

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
    return Add.fromJson(res.data);
  } else if (res.statusCode == 302) {
    throw Exception('SomeThing went Wrong');
  } else {
    throw Exception('failed to create product');
  }
}

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
    return Add.fromJson(res.data);
  } else if (res.statusCode == 302) {
    throw Exception('SomeThing went Wrong');
  } else {
    throw Exception('failed to create product');
  }
}

Future productDelete(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  Response res = await dio.delete("${ApiUrl.baseUrl}products/$id",
      options: Options(followRedirects: true, headers: {
        "Authorization": "Bearer $token",
      }));
  return res;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
