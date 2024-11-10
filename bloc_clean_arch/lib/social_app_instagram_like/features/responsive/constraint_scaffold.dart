/*
  CONSTRAINT SCAFFOLD:

  This is a normal scaffold but it's width is constrained so that it behaves
  consistently on larger screens  (particularly for web browsers)
*/

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConstrainedScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ConstrainedScaffold(
      {super.key,
      required this.body,
      this.appBar,
      this.drawer,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 430),
        child: body,
      ),
    );
  }
}
