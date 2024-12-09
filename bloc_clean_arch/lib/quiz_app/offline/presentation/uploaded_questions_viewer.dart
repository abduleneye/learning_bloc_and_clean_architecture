import 'package:flutter/material.dart';

class UploadedQuestionsViewer extends StatefulWidget {
  final String questionCategory;
  const UploadedQuestionsViewer({
    super.key,
    required this.questionCategory
  });

  @override
  State<UploadedQuestionsViewer> createState() => _UploadedQuestionsViewerState();
}

class _UploadedQuestionsViewerState extends State<UploadedQuestionsViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "UPLOADED QUESTIONS VIEWER"
          ),
          actions: [
            //upload new questions Button
            IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const UploadQuestionsPage()
                //     ));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: const SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.0),
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 500,
                        width: 500,
                        child: Text(
                            "GFHDDWJLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
                            ),
                      )

                    ],
                  )
              )
            )

        )
    );
  }
}
