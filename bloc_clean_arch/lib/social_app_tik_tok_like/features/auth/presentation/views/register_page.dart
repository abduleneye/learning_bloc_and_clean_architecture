import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_social_button.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({
    super.key,
    required this.togglePages,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

              // create an account message
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // name textfield
              MyTextFieldSocialApp(
                controller: nameController,
                hintText: 'Enter your name',
                obscureText: false,
              ),
              const SizedBox(
                height: 10,
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

              // confirm pw textfield
              MyTextFieldSocialApp(
                controller: confirmPasswordController,
                hintText: 'Re-enter your password',
                obscureText: true,
              ),

              const SizedBox(
                height: 10,
              ),

              //register button
              MySocialButton(
                onTap: null,
                buttonText: 'Register',
              ),

              const SizedBox(
                height: 10,
              ),

              //Already have an account? Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(
                      "Login now",
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
