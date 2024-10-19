/*
  LOGIN PAGE
  On this page an existing user can login with thier: 
  - email
  - password

  ----------------------------------------------------
  Once the user logs in succesfully, they will be directed to the home page

  If user doesn't have an account yet, they can go to the register page from here to create a new one.

*/

import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_textfield.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_social_button.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:flutter/material.dart';

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
                onTap: null,
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
