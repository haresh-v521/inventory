import 'package:flutter/material.dart';
import 'package:login_figma/core/provider/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';

class ProductUpdate extends StatefulWidget {
  final dynamic res;
  const ProductUpdate({Key? key, this.res}) : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  late ProductAddProvider modal;

  @override
  void didChangeDependencies() {
    modal = Provider.of<ProductAddProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      modal.pNameController.text = widget.res[2];
      modal.mrpController.text = widget.res[1].toString();
      modal.sellingController.text = widget.res[5].toString();
      modal.descController.text = widget.res[4].toString();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAddProvider>(
      builder: (BuildContext context, modal, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade800,
            elevation: 0,
            title: const Text("Product Update"),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInput(
                controller: modal.pNameController,
                type: TextInputType.name,
                text: "Product name",
                val: false,
                value: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Product name";
                  }
                  return null;
                },
              ),
              CustomInput(
                controller: modal.mrpController,
                text: "Product mrp",
                type: TextInputType.number,
                val: false,
                value: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Product Price";
                  }
                  return null;
                },
              ),
              CustomInput(
                controller: modal.sellingController,
                type: TextInputType.number,
                text: "Product selling item",
                val: false,
                value: false,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please Enter Product Selling item";
                  }
                  return null;
                },
              ),
              CustomInput(
                controller: modal.descController,
                text: "Product description",
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
                onTap: () async {
                  modal.updateProduct(widget.res[3]);
                  Navigator.of(context).pushNamed('listing');
                },
                text: "UPDATE",
                color: Colors.grey.shade800,
                fontColor: Colors.white,
              ),
              CustomButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: "CANCEL",
                color: Colors.grey.shade800,
                fontColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
