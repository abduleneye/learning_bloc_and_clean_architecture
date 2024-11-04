import 'package:flutter/material.dart';

class MySocialButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  const MySocialButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding Inside
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            // color of button
            color: Theme.of(context).colorScheme.tertiary,

            // curved corners
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
