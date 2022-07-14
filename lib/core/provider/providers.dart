import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:login_figma/core/modal/list_product_modal.dart';
import 'dart:io';
import '../modal/profile_update_modal.dart';
import '../modal/register_post_data_modal.dart';
import '../modal/user_profile_modal.dart';
import '../services/http_service.dart';

class DataClass extends ChangeNotifier {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateProductKey = GlobalKey<FormState>();
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
  TextEditingController pNameController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController sellingController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();

  dynamic dropSelectedValue = "";
  bool isLoading = true;
  UserProfile? profile;
  ProfileUpdate? update;
  Listing? list;
  PostData? post;
  ImagePicker picker = ImagePicker();
  File? img;
  List<Datum> items = [];

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

  updateProfile() async {
    isLoading = true;
    update = await profileUpdate(updateNameController.text,
        updateEmailController.text, profile!.user.id);
    isLoading = false;
    notifyListeners();
  }

  updateRating(double rates) {
    rating = rates;
    notifyListeners();
  }

  onDropChanged(val) {
    dropSelectedValue = val;
    notifyListeners();
  }

  userResponse() async {
    isLoading = true;
    profile = await getUser();
    isLoading = false;
    notifyListeners();
  }

  postData() async {
    isLoading = true;
    post = await registerPostData(
      nameController.text,
      emailController.text,
      passwordController.text,
      dateController.text,
      dropSelectedValue,
      confirmPasswordController.text,
    );
    isLoading = false;
    notifyListeners();
  }

  listResponse(int page) async {
    isLoading = true;
    list = await getProduct(page);
    items.addAll(list!.data.data);
    isLoading = false;
    notifyListeners();
  }

  cancelact() {
    productNameController.clear();
    priceController.clear();
    sellingItemController.clear();
    desController.clear();
    img = null;
    notifyListeners();
  }

  imagePick(ImageSource source, context) async {
    XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      img = File(image.path);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
    notifyListeners();
  }

  openDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose"),
          actions: [
            IconButton(
              onPressed: () {
                imagePick(ImageSource.camera, context);
              },
              icon: const Icon(Icons.camera_alt),
            ),
            IconButton(
              onPressed: () {
                imagePick(ImageSource.gallery, context);
              },
              icon: const Icon(Icons.photo),
            ),
          ],
        );
      },
    );
  }

  updateProduct(int id) {
    productUpdate(pNameController.text, mrpController.text,
        sellingController.text, descController.text, id);
    notifyListeners();
  }

  delete(int id) {
    productDelete(id);
    items;
    notifyListeners();
  }
}
