import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final Function()? onTap;
  final bool isQuestion;
  final double? containerHeight;
  final double? containerWidth;
  final double containerInnerPadding;
  final String questionOrOption;
  const QuizCard({
    super.key,
    required this.questionOrOption,
    this.onTap,
    required this.containerHeight,
    required this.containerWidth,
    required this.containerInnerPadding,
    required this.isQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(containerInnerPadding),
        height: containerHeight,
        width: containerWidth,
        child: Center(
            child: Text(
          questionOrOption,
          style: const TextStyle(),
        )),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
