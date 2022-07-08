import 'package:flutter/material.dart';

class ColorPallet extends StatelessWidget {
  final Color color;
  const ColorPallet({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 13,
        backgroundColor: color,
      ),
    );
  }
}
