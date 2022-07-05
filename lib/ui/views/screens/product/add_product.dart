import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/providers.dart';
import '../../../../core/services/http_service.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<DataClass>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
        title: const Text(AppString.barTitle),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Choose"),
                          actions: [
                            IconButton(
                              onPressed: modal.imageCapture,
                              icon: const Icon(Icons.camera_alt),
                            ),
                            IconButton(
                              onPressed: modal.imagePick,
                              icon: const Icon(Icons.photo),
                            ),
                          ],
                        );
                      },
                    );
                    Navigator.of(context).pop();
                  },
                  child: (modal.img == null)
                      ? Container(
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
                        )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                        child: Image.file(modal.img!,
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    fit: BoxFit.fill,
                  ),
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
                  return null;
                },
              ),
              CustomInput(
                controller: modal.priceController,
                text: "Product Price",
                type: TextInputType.name,
                val: false,
                value: false,
                validator: (val) {
                  return null;
                },
              ),
              CustomInput(
                controller: modal.sellingItemController,
                text: "Selling Item",
                type: TextInputType.name,
                val: false,
                value: false,
                validator: (val) {
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
                  return null;
                },
              ),
              CustomButton(
                text: "ADD",
                color: Colors.grey.shade800,
                fontColor: Colors.white,
                onTap: () {
                  addProducts(
                      modal.productNameController.text,
                      modal.priceController.text,
                      modal.sellingItemController.text,
                      modal.desController.text,
                      modal.img!,
                  );
                  modal.cancelact();
                  Navigator.of(context).pop();
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
  }
}
