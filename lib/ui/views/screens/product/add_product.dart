import 'package:flutter/material.dart';
import 'package:login_figma/core/provider/product_provider.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
        title: const Text(AppString.barTitle),
      ),
      body: Consumer<ProductAddProvider>(
        builder: (context, modal, child) {
          return Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: modal.productKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        modal.openDialog(context);
                      },
                      child: (modal.img != null)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                modal.img!,
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 2.5,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade400,
                              ),
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 80,
                                color: Colors.grey.shade900,
                              ),
                            ),
                    ),
                    CustomInput(
                      controller: modal.productNameController,
                      text: "Product Name",
                      type: TextInputType.name,
                      val: false,
                      value: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Product Name";
                        }
                        return null;
                      },
                    ),
                    CustomInput(
                      controller: modal.priceController,
                      text: "Product Price",
                      type: TextInputType.number,
                      val: false,
                      value: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Product price";
                        }
                        return null;
                      },
                    ),
                    CustomInput(
                      controller: modal.sellingItemController,
                      text: "selling Item",
                      type: TextInputType.number,
                      val: false,
                      value: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Product Selling Item";
                        }
                        return null;
                      },
                    ),
                    CustomInput(
                      controller: modal.desController,
                      text: "Description",
                      type: TextInputType.name,
                      val: false,
                      value: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please Enter Product Description";
                        }
                        return null;
                      },
                    ),
                    CustomButton(
                      text: "ADD",
                      color: Colors.grey.shade800,
                      fontColor: Colors.white,
                      onTap: () {
                        if (modal.productKey.currentState!.validate()) {
                          modal.addProduct(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProductListing(),
                            ),
                          );
                          modal.cancelact();
                        }
                      },
                    ),
                    CustomButton(
                      onTap: modal.cancelact,
                      text: "RESET",
                      color: Colors.grey.shade800,
                      fontColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
