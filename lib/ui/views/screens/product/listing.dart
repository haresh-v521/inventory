import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_product_list.dart';
import '../../../widget/listtile.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppString.product,
          style: GoogleFonts.marmelad(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('addProduct');
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            CustomListTile(
              text: "Add another Account",
              icon: const Icon(Icons.add),
              color: Colors.transparent,
              callback: () {
                Navigator.of(context).pushNamed('login');
              },
            ),
            CustomListTile(
              text: "My Profile",
              icon: const Icon(Icons.person),
              color: Colors.transparent,
              callback: () {
                Navigator.of(context).pushNamed('profile');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(
                    30,
                  ),
                ),
              ),
            ),
          ),
          ProductList(
            onTap: () {
              Navigator.of(context).pushNamed('detail');
            },
            image: AppString.playImg,
            bluImage: AppString.bluImg,
            price: AppString.price,
            bluText: AppString.blue,
          ),
          ProductList(
            onTap: () {},
            image: AppString.playImg,
            bluImage: AppString.bluImg,
            price: AppString.price,
            bluText: AppString.blue,
          ),
          ProductList(
            image: AppString.playImg,
            bluImage: AppString.bluImg,
            price: AppString.price,
            bluText: AppString.blue,
            onTap: () {},
          ),
          ProductList(
            image: AppString.playImg,
            bluImage: AppString.bluImg,
            price: AppString.price,
            bluText: AppString.blue,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
