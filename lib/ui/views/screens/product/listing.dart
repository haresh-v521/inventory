import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_figma/core/provider/providers.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_product_list.dart';
import '../../../widget/listtile.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  int page = 21;
  ScrollController scrollController = ScrollController();

  late DataClass modal ;

  @override
  void didChangeDependencies() {
   modal = Provider.of<DataClass>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      modal.listResponse(page);
      scrollController.addListener(() {
      print("....");
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                height: MediaQuery.of(context).size.height / 10.5,
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
            Expanded(
              child: (modal.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: modal.list!.data.data.length,
                      itemBuilder: (context, i) {
                        return ProductList(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('detail', arguments: [
                              modal.list?.data.data[i].name,
                              modal.list?.data.data[i].mrp,
                              modal.list?.data.data[i].img,
                            ]);
                          },
                          image: AppString.playImg,
                          bluImage: "${modal.list?.data.data[i].img}",
                          price: "${modal.list?.data.data[i].mrp}",
                          bluText: "${modal.list?.data.data[i].name}",
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
