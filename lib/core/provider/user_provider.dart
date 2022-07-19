import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modal/profile_update_modal.dart';
import '../modal/user_profile_modal.dart';
import '../services/get_user_service.dart';
import '../services/profile_update_service.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = true;
  UserProfile? profile;
  ProfileUpdate? update;
  dynamic dropSelectedValue = "";
  DateTime initialDate = DateTime.now();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  updateProfile() async {
    isLoading = true;
    update = await profileUpdate(updateNameController.text,
        updateEmailController.text, profile!.user.id);
    isLoading = false;
    notifyListeners();
  }

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
}
