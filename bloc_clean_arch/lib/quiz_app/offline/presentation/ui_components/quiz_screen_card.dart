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
      child: Card(
        elevation: 4.0,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(containerInnerPadding),
          height: containerHeight,
          width: containerWidth,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: Text(
                softWrap: true,
                questionOrOption,
                style: const TextStyle(
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ]),
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
      )
    );
  }
}
