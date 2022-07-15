import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_figma/ui/views/screens/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/provider/providers.dart';
import '../../../../utils/constant/app_assets.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/login_button.dart';
import '../../../widget/textfield.dart';
import '../product/listing.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<DataClass>(context);
    return Scaffold(
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
            height: MediaQuery.of(context).size.height / 2.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              AppString.wel,
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
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Form(
                key: modal.key,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          AppString.sign,
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
                        controller: modal.nameController,
                        text: AppString.name,
                        type: TextInputType.name,
                        val: false,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter your name";
                          }
                          return null;
                        },
                      ),
                      CustomInput(
                        controller: modal.emailController,
                        text: AppString.email,
                        type: TextInputType.emailAddress,
                        val: false,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter your email";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      CustomInput(
                        controller: modal.passwordController,
                        text: AppString.password,
                        type: TextInputType.number,
                        val: true,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter your password";
                          } else if (val.length > 6) {
                            return "Password must be at least 6 character long";
                          }
                          return null;
                        },
                      ),
                      CustomInput(
                        controller: modal.confirmPasswordController,
                        text: AppString.confirm,
                        type: TextInputType.number,
                        val: true,
                        value: false,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "Please Enter your password again";
                          } else if (modal.passwordController.text !=
                              modal.confirmPasswordController.text) {
                            return "Password is not match ";
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 18, left: 18, top: 15, bottom: 5),
                              child: DropdownButtonFormField(
                                hint: const Text("Select"),
                                decoration: const InputDecoration(
                                  labelText: AppString.gender,
                                  border: OutlineInputBorder(),
                                ),
                                items: modal.dropValues,
                                onChanged: modal.onDropChanged,
                              ),
                            ),
                          ),
                          Expanded(
                            child: CustomInput(
                              controller: modal.dateController,
                              onTap: () {
                                modal.onTap(context);
                              },
                              text: AppString.dob,
                              type: TextInputType.datetime,
                              val: false,
                              icon: const Icon(Icons.calendar_today),
                              value: true,
                              validator: (String? val) {
                                if (val!.isEmpty) {
                                  return "Please Enter your Birth Date";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        text: AppString.sign,
                        color: Colors.grey.shade800,
                        fontColor: Colors.white,
                        onTap: () async {
                          if (modal.key.currentState!.validate()) {
                            modal.postData();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ProductListing(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Sign in failed? Please try again"),
                              ),
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: RichText(
                          text: TextSpan(
                            text: AppString.alr,
                            style: GoogleFonts.marmelad(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: AppString.log,
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
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
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
          ),
        ],
      ),
    );
  }
}
