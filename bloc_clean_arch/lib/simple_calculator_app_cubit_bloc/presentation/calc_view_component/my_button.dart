import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String id;
  const MyButton({super.key, required this.onTap, required this.id});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
        onTap: onTap,
        child: Container(
            width: 132,
            height: 132,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 190, 236),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Text(
              id,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))));
  }
}
