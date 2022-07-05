import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../core/provider/providers.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_container.dart';
import '../../../widget/login_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<DataClass>(context, listen: false).userResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final modal = Provider.of<DataClass>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text(AppString.title),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/img_1.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                    "${modal.profile?.user.name}",
                      style: GoogleFonts.marmelad(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "${modal.profile?.user.email}",
                      style: GoogleFonts.marmelad(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                     CustomContainer(text: modal.nameController.text),
                     CustomContainer(text: modal.emailController.text),
                     CustomContainer(text: modal.dropSelectedValue),
                     CustomContainer(text: modal.dateController.text),
                  ],
                ),
              ),
            ),
            CustomButton(
              text: AppString.edit,
              color: Colors.grey.shade800,
              fontColor: Colors.white,
              onTap: () {
                Navigator.of(context).pushNamed('edit');
              },
            ),
          ],
        ),
      ),
    );
  }
}
