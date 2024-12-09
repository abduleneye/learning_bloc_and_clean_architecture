import 'dart:convert';

import 'package:bloc_clean_arch/quiz_app/offline/data/local/quiz_repo_implementation.dart';
import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_repo.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/quiz_bloc/quiz_events.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/quiz_bloc/quiz_states.dart';
import 'package:bloc_clean_arch/quiz_app/offline/presentation/uploaded_questions_viewer.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view_component/my_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadQuestionEntryModifierPage extends StatefulWidget {
  final String questionCategory;
  const UploadQuestionEntryModifierPage({
    super.key,
    required this.questionCategory
  });

  @override
  State<UploadQuestionEntryModifierPage> createState() => _UploadQuestionEntryModifierPageState();
}

class _UploadQuestionEntryModifierPageState extends State<UploadQuestionEntryModifierPage> {
  // text Controller
  final questionUploadTexFieldController = TextEditingController();
  final QuizRepo quizRepo = QuizRepoImplementation();

  @override
  void dispose() {
    questionUploadTexFieldController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
            "UPLOAD QUESTION"
        ),
      ),
      body: SafeArea(
          child: BlocBuilder<QuizBloc, QuizStates>(builder: (context, state){
            if(state is QuizLoading){
             return  const Center(
                child: CircularProgressIndicator(),
              );

            }else {
               return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            maxLines: 20,
                            controller: questionUploadTexFieldController,
                            decoration: InputDecoration(
                              //border when unselected
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              //border when selected
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "${widget.questionCategory} in JSON format",
                              hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                              fillColor: Theme.of(context).colorScheme.secondary,
                              filled: true,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0 ,
                          ),
                          InkResponse(
                              onTap: (){
                                if(
                                questionUploadTexFieldController.text.isNotEmpty
                                ){
                                  try{
                                    jsonDecode(questionUploadTexFieldController.text);
                                    context
                                        .read<QuizBloc>()
                                        .add(UploadQuestionToFireStore(
                                        questions: questionUploadTexFieldController.text,
                                        questionCategory: widget.questionCategory

                                    ));


                                  }catch(e){
                                    Fluttertoast.showToast(
                                        msg: "questions is not in json format",
                                        //  toastLength: Toast.LENGTH_LONG,
                                        // gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 10.0);

                                  }
                                }else{
                                  Fluttertoast.showToast(
                                      msg: "questions can't be empty",
                                      //  toastLength: Toast.LENGTH_LONG,
                                      // gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 10.0);


                                }

                              },
                              child: Container(

                                  padding: const EdgeInsets.all(25),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 231, 190, 236),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Upload ${widget.questionCategory} questions",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      )))),
                          const SizedBox(
                            height: 10.0 ,
                          ),
                          InkResponse(
                              onTap: (){

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              QuizBloc(quizRepo: quizRepo),
                                          child:  UploadedQuestionsViewer(
                                            questionCategory: widget.questionCategory,
                                          ),
                                        )));

                              },
                              child: Container(

                                  padding: const EdgeInsets.all(25),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 231, 190, 236),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                      child: Text(
                                        "View ${widget.questionCategory} questions",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ))))

                        ],
                      )

                    ],
                  )
              );
            }

          })
      )
    );
  }
}
