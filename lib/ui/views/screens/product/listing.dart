import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_figma/core/provider/user_provider.dart';
import 'package:login_figma/ui/views/screens/login/login_screen.dart';
import 'package:login_figma/ui/views/screens/profile/profile_page.dart';
import 'package:login_figma/ui/widget/login_button.dart';
import 'package:login_figma/utils/constant/app_assets.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/product_provider.dart';
import '../../../../utils/constant/app_string.dart';
import '../../../widget/custom_product_list.dart';
import '../../../widget/listtile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'add_product.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  late ProductAddProvider modal;
  late UserProvider userModal;

  int page = 1;
  ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    modal = Provider.of<ProductAddProvider>(context);
    userModal = Provider.of<UserProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      modal.listResponse(page, context);
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (page <= modal.list!.data.lastPage) {
            modal.listResponse(page += 1, context);
          } else {
            return;
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProducts(),
                  ),
                );
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
          backgroundColor: Colors.grey.shade300,
          child: Column(
            children: [
              DrawerHeader(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: (userModal.profile?.user.gender == "FeMale")
                      ? const AssetImage(Assets.female)
                      : const AssetImage(Assets.male),
                ),
              ),
              CustomListTile(
                text: "Add another Account",
                icon: const Icon(Icons.add),
                color: Colors.transparent,
                callback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              CustomListTile(
                text: "My Profile",
                icon: const Icon(Icons.person),
                color: Colors.transparent,
                callback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              CustomListTile(
                text: "Log Out",
                icon: const Icon(Icons.logout),
                color: Colors.transparent,
                callback: () {
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
                    bottomLeft: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Consumer<ProductAddProvider>(
              builder: (BuildContext context, modal, child) {
                return Expanded(
                  child: (modal.isLoading)
                      ? Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            size: 200,
                            color: Colors.grey.shade800,
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: modal.items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == modal.items.length) {
                              return Center(
                                child: Opacity(
                                  opacity: 0.7,
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    size: 100,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              );
                            } else {
                              return TweenAnimationBuilder(
                                tween: Tween<Offset>(
                                  begin: (index.isEven)
                                      ? const Offset(300, 0)
                                      : const Offset(0, -300),
                                  end: const Offset(0, 0),
                                ),
                                builder: (BuildContext context, Offset val,
                                    Widget? child) {
                                  return Transform.translate(
                                    offset: val,
                                    child: ProductList(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          'detail',
                                          arguments: [
                                            (modal.items[index].img == null)
                                                ? Assets.noImage
                                                : modal.items[index].img,
                                            modal.items[index].mrp,
                                            modal.items[index].name,
                                            modal.items[index].id,
                                            modal.items[index].description,
                                            modal.items[index].selling,
                                          ],
                                        );
                                      },
                                      image: Assets.playImg,
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                  AppString.delete,
                                                ),
                                                content: const Text(
                                                  AppString.record,
                                                ),
                                                actions: [
                                                  CustomButton(
                                                    onTap: () {
                                                      modal.delete(modal
                                                          .items[index].id);
                                                      modal.items
                                                          .removeAt(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors.red,
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Text(
                                                            "Product Deleted Successfully",
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    text: 'DELETE',
                                                    fontColor: Colors.white,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                  CustomButton(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    text: 'CANCEL',
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade800),
                                                    fontColor:
                                                        Colors.grey.shade800,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      bluImage: (modal.items[index].img == null)
                                          ? Assets.noImage
                                          : "${modal.items[index].img}",
                                      price:
                                          "Price : ${modal.items[index].mrp}",
                                      bluText:
                                          modal.items[index].name.toUpperCase(),
                                    ),
                                  );
                                },
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
