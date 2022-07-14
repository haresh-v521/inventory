import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider/providers.dart';
import '../../../../core/services/http_service.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<DataClass>(context);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 83, left: 26),
              alignment: Alignment.topLeft,
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppString.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                AppString.back,
                style: GoogleFonts.marmelad(
                  textStyle: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Form(
                  key: modal.loginKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          AppString.log,
                          style: GoogleFonts.marmelad(
                            textStyle: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      CustomInput(
                        controller: modal.loginEmailController,
                        text: AppString.email,
                        type: TextInputType.emailAddress,
                        val: false,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter Valid Email";
                          }
                          return null;
                        },
                      ),
                      CustomInput(
                        controller: modal.loginPasswordController,
                        text: AppString.pass,
                        type: const TextInputType.numberWithOptions(),
                        val: true,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter your password";
                          } else if (val.length < 6) {
                            return "Password must be at least 6 character long";
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 14, top: 15, bottom: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppString.forget,
                            style: GoogleFonts.marmelad(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomButton(
                        text: AppString.login,
                        color: Colors.grey.shade800,
                        fontColor: Colors.white,
                        onTap: () {
                          if (modal.loginKey.currentState!.validate()) {
                            loginPostData(
                              modal.loginEmailController.text,
                              modal.loginPasswordController.text,
                            );
                            Navigator.of(context)
                                .pushReplacementNamed('listing');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Failed"),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RichText(
                          text: TextSpan(
                            text: AppString.don,
                            style: GoogleFonts.marmelad(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: AppString.sign,
                                style: GoogleFonts.marmelad(
                                  textStyle: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('signUp');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
