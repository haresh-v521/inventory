import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color fontColor;
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.color,
      required this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 45, right: 45, top: 12),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(text,
            style: GoogleFonts.marmelad(
              textStyle: TextStyle(
                  color: fontColor, fontSize: 18, fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}
