import 'package:flutter/material.dart';
import 'package:login_figma/core/provider/product_provider.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:provider/provider.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';

class ProductUpdate extends StatefulWidget {
  final String? name;
  final int? mrp;
  final int? selling;
  final String? description;
  final int? id;

  const ProductUpdate(
      {Key? key, this.name, this.mrp, this.selling, this.description, this.id})
      : super(key: key);

  @override
  State<ProductUpdate> createState() => _ProductUpdateState();
}

class _ProductUpdateState extends State<ProductUpdate> {
  late ProductAddProvider modal;

  @override
  void didChangeDependencies() {
    modal = Provider.of<ProductAddProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      modal.pNameController.text = widget.name!;
      modal.mrpController.text = widget.mrp.toString();
      modal.sellingController.text = widget.selling.toString();
      modal.descController.text = widget.description.toString();
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
                  modal.updateProduct(widget.id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProductListing(),
                    ),
                  );
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
