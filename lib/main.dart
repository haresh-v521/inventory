import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_figma/core/provider/login_provider.dart';
import 'package:login_figma/core/provider/product_provider.dart';
import 'package:login_figma/core/provider/sign_up_provider.dart';
import 'package:login_figma/core/provider/user_provider.dart';
import 'package:login_figma/ui/views/homepage.dart';
import 'package:login_figma/ui/views/screens/login/login_screen.dart';
import 'package:login_figma/ui/views/screens/login/signup_screen.dart';
import 'package:login_figma/ui/views/screens/product/add_product.dart';
import 'package:login_figma/ui/views/screens/product/listing.dart';
import 'package:login_figma/ui/views/screens/product/product_detail.dart';
import 'package:login_figma/ui/views/screens/product/product_update.dart';
import 'package:login_figma/ui/views/screens/profile/edit_profile.dart';
import 'package:login_figma/ui/views/screens/profile/profile_page.dart';
import 'package:login_figma/ui/views/screens/splash/main_splash.dart';
import 'package:provider/provider.dart';
import 'core/services/sign_up_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
          child: const LoginPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const SignUp(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const EditProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const ProfilePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const AddProducts(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductAddProvider(),
          child: const ProductDetail(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const ProductListing(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataClass(),
          child: const ProductUpdate(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {
          '/': (context) => const HomePage(),
          'splash': (context) => const MainSplash(),
          'login': (context) => const LoginPage(),
          'signUp': (context) => const SignUp(),
          'addProduct': (context) => const AddProducts(),
          'detail': (context) => const ProductDetail(),
          'listing': (context) => const ProductListing(),
          'profile': (context) => const ProfilePage(),
          'edit': (context) => const EditProfile(),
          'edit_product': (context) => const ProductUpdate(),
        },
      ),
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
}
