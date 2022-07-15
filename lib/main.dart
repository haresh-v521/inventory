import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_figma/core/provider/providers.dart';
import 'package:login_figma/ui/views/homepage.dart';
import 'package:login_figma/ui/views/screens/login/login_screen.dart';
import 'package:login_figma/ui/views/screens/login/signUp_screen.dart';
import 'package:login_figma/ui/views/screens/product/add_product.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:login_figma/ui/views/screens/product/product_detail.dart';
import 'package:login_figma/ui/views/screens/profile/edit_profile.dart';
import 'package:login_figma/ui/views/screens/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'core/services/http_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const Authenticate(),
  );
  HttpOverrides.global = MyHttpOverrides();
}

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const LoginPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const SignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const EditProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const ProfilePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const AddProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const ProductDetail(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const ProductListing(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          'login': (context) => const LoginPage(),
          'signUp': (context) => const SignUp(),
          'addProduct': (context) => const AddProducts(),
          'detail': (context) => const ProductDetail(),
          'listing': (context) => const ProductListing(),
          'profile': (context) => const ProfilePage(),
          'edit': (context) => const EditProfile(),
        },
      ),
    );
  }
}
