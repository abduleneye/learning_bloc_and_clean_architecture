/*

Auth page - This to determine wether to show the login or register page

*/

import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/login_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // intially, show login pages
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        togglePages: togglePages,
      );
    } else {
      return RegisterPage(togglePages: togglePages);
    }
  }
}
