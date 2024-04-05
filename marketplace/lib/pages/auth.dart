import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/pages/LoginOrRegister.dart';
import 'package:marketplace/pages/intro_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return const IntroPage();
          }

          // user not logged in
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
