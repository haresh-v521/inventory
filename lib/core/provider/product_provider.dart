import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../modal/add_product_modal.dart';
import '../modal/list_product_modal.dart';
import '../modal/product_update_modal.dart';
import '../services/add_product_service.dart';
import '../services/pagination_service.dart';
import '../services/product_delete_service.dart';
import '../services/product_update_service.dart';

class ProductAddProvider extends ChangeNotifier {
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellingItemController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController pNameController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController sellingController = TextEditingController();
  TextEditingController descController = TextEditingController();
  File? img;
  Listing? list;
  UpdateProduct? product;
  List<Datum> items = [];
  Add? productsAdd;
  bool isLoading = true;
  ImagePicker picker = ImagePicker();

  cancelact() {
    productNameController.clear();
    priceController.clear();
    sellingItemController.clear();
    desController.clear();
    img = null;
    notifyListeners();
  }

  addProduct() async {
    productsAdd = await addProducts(
      productNameController.text,
      int.parse(priceController.text),
      int.parse(sellingItemController.text),
      desController.text,
      img!,
    );
    items.addAll(list!.data.data);
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
          title: const Text("Choose picture from Camera or Gallery"),
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

  updateProduct(int id) async {
    isLoading = true;
    product = await productUpdate(pNameController.text, mrpController.text,
        sellingController.text, descController.text, id);
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

  delete(int id) async {
    isLoading = true;
    await productDelete(id);
    isLoading = false;
    notifyListeners();
  }
}
