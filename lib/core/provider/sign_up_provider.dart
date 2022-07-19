import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_figma/core/modal/list_product_modal.dart';
import 'dart:io';
import '../modal/register_post_data_modal.dart';
import '../services/sign_up_service.dart';

class DataClass extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DateTime initialDate = DateTime.now();
  double rating = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  dynamic dropSelectedValue = "";
  bool isLoading = true;
  Listing? list;
  PostData? post;
  File? img;
  bool? status;

  List<DropdownMenuItem<String>> dropValues = <DropdownMenuItem<String>>[
    const DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    const DropdownMenuItem(
      value: "FeMale",
      child: Text("FeMale"),
    ),
    const DropdownMenuItem(
      value: "Other",
      child: Text("Other"),
    ),
  ];

  onTap(context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      String formattedDate = DateFormat.yMd().format(selected);
      dateController.text = formattedDate;
      notifyListeners();
    }
  }

  updateRating(double rates) {
    rating = rates;
    notifyListeners();
  }

  onDropChanged(val) {
    dropSelectedValue = val;
    notifyListeners();
  }

  postData(context) async {
    isLoading = true;
    post = await registerPostData(
        nameController.text,
        emailController.text,
        int.parse(
          passwordController.text,
        ),
        dateController.text,
        dropSelectedValue,
        confirmPasswordController.text,
        context);
    isLoading = false;
    notifyListeners();
  }
}
