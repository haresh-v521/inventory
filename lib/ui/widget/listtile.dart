import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Widget icon;
  final Color color ;
  const CustomListTile(
      {Key? key,
      required this.text,
      required this.callback,
      required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: (){},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: ListTile(
            leading: Text(
              text,
              style: GoogleFonts.marmelad(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            trailing: IconButton(onPressed: callback, icon: icon),
          ),
        ),
      ),
    );
  }
}
