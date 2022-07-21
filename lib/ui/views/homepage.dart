import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_figma/ui/views/screens/login/login_screen.dart';
import 'package:login_figma/ui/views/screens/login/signup_screen.dart';
import 'package:login_figma/utils/constant/app_assets.dart';

import '../../utils/constant/app_string.dart';
import '../widget/login_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 83, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  AppString.wel,
                  style: GoogleFonts.marmelad(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                AppString.ple,
                style: GoogleFonts.marmelad(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            CustomButton(
              text: AppString.login,
              color: Colors.white,
              fontColor: Colors.black,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
            CustomButton(
              text: AppString.signUp,
              color: Colors.white,
              fontColor: Colors.black,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignUp(),
                  ),
                );
              },
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
