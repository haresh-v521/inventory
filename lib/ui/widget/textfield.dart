import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final String text ;
  final TextInputType type ;
  final bool val ;
  final Widget? icon ;
  final TextEditingController? controller ;
  final VoidCallback? onTap ;
  final String? Function(String?)? validator;
  final bool value ;
  const CustomInput({Key? key, required this.text, required this.type,required this.val, this.icon, this.onTap, required this.value, this.controller, required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18,left: 18,top: 15,bottom: 5),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        keyboardType: type,
        controller: controller,
        obscureText: val,
        onTap: onTap,
        readOnly: value,
        decoration:  InputDecoration(
          suffixIcon: icon,
          border: const OutlineInputBorder(),
          labelText: text,
          labelStyle: GoogleFonts.marmelad(textStyle: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14))
        ),
      ),
    );
  }
}

