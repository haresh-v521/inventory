import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const CustomText(
      {Key? key, required this.text, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Text(
        text,
        style: GoogleFonts.marmelad(
          textStyle: TextStyle(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}
