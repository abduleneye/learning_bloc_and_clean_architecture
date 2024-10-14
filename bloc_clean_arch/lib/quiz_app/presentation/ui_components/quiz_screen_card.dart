import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final Function()? onTap;
  final String containerColorState;
  final double? containerHeight;
  final double? containerWidth;
  final double containerInnerPadding;
  final String questionOrOption;
  const QuizCard(
      {super.key,
      required this.questionOrOption,
      this.onTap,
      required this.containerHeight,
      required this.containerWidth,
      required this.containerInnerPadding,
      required this.containerColorState});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(containerInnerPadding),
        height: containerHeight,
        width: containerWidth,
        child: Center(
            child: Row(
          children: [
            Text(
              questionOrOption,
              style: const TextStyle(),
            ),
          ],
        )),
        decoration: BoxDecoration(
          color: () {
            switch (containerColorState) {
              case 'iscorrect':
                return Colors.green;
              case 'iswrong':
                return Colors.red;
              default:
                return Colors.grey;
            }
          }(),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
