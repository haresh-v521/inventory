import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:login_figma/ui/views/homepage.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:login_figma/utils/constant/app_assets.dart';
import 'package:login_figma/utils/constant/app_string.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainSplash extends StatefulWidget {
  const MainSplash({Key? key}) : super(key: key);

  @override
  State<MainSplash> createState() => _MainSplashState();
}

class _MainSplashState extends State<MainSplash> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? status = prefs.getBool('status');
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 2),
            pageBuilder: (context, animation, animation2) {
              return (status == null)
                  ? const HomePage()
                  : const ProductListing();
            },
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.easeInOut,
                parent: animation,
              );
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              alignment: Alignment.center,
              child: const RiveAnimation.asset(
                Assets.ballImg,
                fit: BoxFit.contain,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  AppString.wel,
                  textStyle: const TextStyle(
                    fontSize: 50.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
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
