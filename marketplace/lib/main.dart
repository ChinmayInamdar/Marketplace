import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/firebase_options.dart';
import 'package:marketplace/pages/auth.dart';
import 'package:marketplace/pages/cart_page.dart';
import 'package:marketplace/pages/intro_page.dart';
import 'package:marketplace/pages/list_product.dart';
import 'package:marketplace/pages/shop_page.dart';
import 'package:marketplace/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: lightMode,
      routes: {
        '/intro_page':(context) => const IntroPage(),
        '/shop_page':(context) => const ShopPage(),
        '/cart_page':(context) => const CartPage(),
        '/list_product_page': (context) => const ListProductPage(),
      },
    );
  }
}
