import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_figma/ui/views/screens/product/product_update.dart';
import 'package:login_figma/ui/widget/custom_color_pallat.dart';
import 'package:login_figma/ui/widget/login_button.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/sign_up_provider.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_text.dart';

class ProductDetail extends StatefulWidget {
  final String? img;
  final String? name;
  final int? mrp;
  final int? selling;
  final String? description;
  final int? id;

  const ProductDetail(
      {Key? key,
      this.img,
      this.name,
      this.mrp,
      this.selling,
      this.description,
      this.id})
      : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.detail,
          style: GoogleFonts.marmelad(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Consumer<DataClass>(
          builder: (context, modal, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "${widget.img}",
                        height: 250,
                        width: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  color: Colors.grey.shade800,
                  text: widget.name.toString().toUpperCase(),
                  size: 18,
                ),
                CustomText(
                  color: Colors.grey.shade500,
                  text: "Price : ${widget.mrp} \$",
                  size: 16,
                ),
                CustomText(
                  color: Colors.grey.shade500,
                  text: "Selling item : ${widget.selling} Item",
                  size: 16,
                ),
                Row(
                  children: [
                    CustomText(
                      text: AppString.color,
                      color: Colors.grey.shade800,
                      size: 18,
                    ),
                    const ColorPallet(
                      color: Colors.red,
                    ),
                    const ColorPallet(
                      color: Colors.indigo,
                    ),
                    const ColorPallet(
                      color: Colors.grey,
                    ),
                    const ColorPallet(
                      color: Colors.black,
                    ),
                  ],
                ),
                CustomText(
                  color: Colors.grey.shade800,
                  text: AppString.description,
                  size: 18,
                ),
                CustomText(
                  color: Colors.grey.shade500,
                  text: widget.description.toString().toUpperCase(),
                  size: 16,
                ),
                CustomText(
                  color: Colors.grey.shade800,
                  text: AppString.rating,
                  size: 18,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: modal.updateRating,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        modal.rating.toString(),
                        style: GoogleFonts.marmelad(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: CustomButton(
                    text: "Edit Product",
                    color: Colors.grey.shade800,
                    fontColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 2),
                          pageBuilder: (context, animation, animation2) {
                            return ProductUpdate(
                              id: widget.id,
                              description: widget.description,
                              mrp: widget.mrp,
                              name: widget.name,
                              selling: widget.selling,
                            );
                          },
                          transitionsBuilder:
                              (context, animation, anotherAnimation, child) {
                            animation = CurvedAnimation(
                              curve: Curves.easeInOut,
                              parent: animation,
                            );
                            return RotationTransition(
                              turns: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
