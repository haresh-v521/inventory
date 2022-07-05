import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/providers.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/listtile.dart';
import '../../../widget/login_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final modal = Provider.of<DataClass>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title:  Text(AppString.edit,style: GoogleFonts.marmelad(),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
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
                Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/img_1.png"),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      right: 0,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "User Name",
                    style: GoogleFonts.marmelad(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "user123@gmail.com",
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
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomListTile(
                    text: "User Name",
                    callback: () {},
                    icon: const Icon(
                      Icons.edit,
                    ), color: Colors.black,
                  ),
                  CustomListTile(
                    text: "user123@gmail.com",
                    callback: () {},
                    icon: const Icon(
                      Icons.edit,
                    ), color: Colors.black,
                  ),
                  CustomListTile(
                    text: "Male",
                    callback: () {},
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,size: 25,
                    ), color: Colors.black,
                  ),
                  CustomListTile(
                    text: modal.dateController.text,
                    callback: (){
                      modal.onTap(context);
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                    ), color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: AppString.save,
            color: Colors.grey.shade800,
            fontColor: Colors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
