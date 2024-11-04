/*
  LOGIN PAGE
  On this page an existing user can login with thier: 
  - email
  - password

  ----------------------------------------------------
  Once the user logs in succesfully, they will be directed to the home page

  If user doesn't have an account yet, they can go to the register page from here to create a new one.

*/

import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/components/my_social_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // prepare email and pw
  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    //auth bloc-cubit
    final AuthBlocCubits authBlocCubits = context.read<AuthBlocCubits>();

    //ensure that fields are no empty
    if (email.isNotEmpty && password.isNotEmpty) {
      authBlocCubits.login(
        email,
        password,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter both email and password')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(
                height: 50,
              ),

              // welcome back msg
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // email textfield
              MyTextFieldSocialApp(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
              ),

              // pw textfield
              MyTextFieldSocialApp(
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              //login button
              MySocialButton(
                onTap: () {
                  login();
                },
                buttonText: 'Login',
              ),

              const SizedBox(
                height: 10,
              ),

              //not a member? register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
