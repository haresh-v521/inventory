import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:rive/rive.dart';

class SplashSignUp extends StatefulWidget {
  const SplashSignUp({Key? key}) : super(key: key);

  @override
  State<SplashSignUp> createState() => _SplashSignUpState();
}

class _SplashSignUpState extends State<SplashSignUp> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProductListing(),
        ),
      );
    });
    super.initState();
  }

  TextStyle colorizeTextStyle =
      const TextStyle(fontSize: 50.0, color: Colors.green);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              alignment: Alignment.center,
              child: const RiveAnimation.asset(
                "assets/rive_animations/checked.riv",
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Registered',
                  textStyle: colorizeTextStyle,
                ),
                WavyAnimatedText(
                  'Success',
                  textStyle: colorizeTextStyle,
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ],
        ),
      ),
    );
  }
}