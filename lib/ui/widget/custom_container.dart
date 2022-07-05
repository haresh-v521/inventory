import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final Widget? child;

  const CustomContainer({Key? key, required this.text, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding:
            const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: GoogleFonts.marmelad(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
