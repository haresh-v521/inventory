import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/providers.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_text.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<DataClass>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: Column(
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
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppString.bluetooth,
              height: 140,
            ),
          ),
          CustomText(
            color: Colors.grey.shade800,
            text: AppString.blue,
            size: 18,
          ),
          CustomText(
            color: Colors.grey.shade500,
            text: AppString.price,
            size: 16,
          ),
          CustomText(
            color: Colors.grey.shade800,
            text: AppString.highlight,
            size: 18,
          ),
          CustomText(
            color: Colors.grey.shade500,
            text: AppString.proDetail,
            size: 16,
          ),
          Row(
            children: [
              CustomText(
                text: AppString.color,
                color: Colors.grey.shade800,
                size: 18,
              ),
              const CircleAvatar(
                radius: 10,
              ),
              const CircleAvatar(
                radius: 10,
              ),
              const CircleAvatar(
                radius: 10,
              ),
              const CircleAvatar(
                radius: 10,
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
            text: AppString.content,
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
        ],
      ),
    );
  }
}
