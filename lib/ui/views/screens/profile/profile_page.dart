import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login_figma/core/provider/user_provider.dart';
import 'package:login_figma/ui/views/screens/profile/edit_profile.dart';
import 'package:login_figma/utils/constant/app_assets.dart';
import 'package:provider/provider.dart';
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
      Provider.of<UserProvider>(context, listen: false).userResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, modal, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            title: const Text(AppString.title),
            centerTitle: true,
            backgroundColor: Colors.grey.shade800,
          ),
          body: (modal.isLoading)
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    size: 200,
                    color: Colors.grey.shade800,
                  ),
                )
              : SingleChildScrollView(
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
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    (modal.profile?.user.gender == "FeMale")
                                        ? const AssetImage(Assets.female)
                                        : const AssetImage(Assets.male),
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
                            children: [
                              CustomContainer(
                                  text: "${modal.profile?.user.name}"),
                              CustomContainer(
                                  text: "${modal.profile?.user.email}"),
                              CustomContainer(
                                  text: "${modal.profile?.user.gender}"),
                              CustomContainer(
                                  text:
                                      "${modal.profile?.user.birthDate.day} / ${modal.profile?.user.birthDate.month} / ${modal.profile?.user.birthDate.year}"),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        text: AppString.edit,
                        color: Colors.grey.shade800,
                        fontColor: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
