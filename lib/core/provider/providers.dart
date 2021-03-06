import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../modal/user_profile_modal.dart';
import '../services/http_service.dart';

class DataClass extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  DateTime initialDate = DateTime.now();
  double rating = 0;
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellingItemController = TextEditingController();
  TextEditingController desController = TextEditingController();
  dynamic dropSelectedValue = "";
  UserProfile? profile ;
  ImagePicker picker = ImagePicker();
  File? img ;

  List<DropdownMenuItem<String>> dropValues = <DropdownMenuItem<String>>[
    const DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    const DropdownMenuItem(
      value:"FeMale",
      child: Text("FeMale"),
    ),
    const DropdownMenuItem(
      value: "Other",
      child: Text("Other"),
    ),
  ];

  onTap(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(selected);
      dateController.text = formattedDate;
      notifyListeners();
    }
  }

  updateRating(double rates) {
    rating = rates;
    notifyListeners();
  }

  onDropChanged(val){
    dropSelectedValue = val;
    notifyListeners();
  }
  userResponse()async {
    profile = await getUser();
    notifyListeners();
  }
  cancelact(){
    productNameController.clear();
    priceController.clear();
    sellingItemController.clear();
    desController.clear();
  }
  imagePick() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    img = File(image!.path);
    notifyListeners();
  }
  imageCapture() async {
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    img = File(image!.path);
    notifyListeners();
  }
}
