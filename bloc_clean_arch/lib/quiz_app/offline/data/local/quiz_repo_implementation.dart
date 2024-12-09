import 'dart:convert';
import 'dart:math';

import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_model.dart';
import 'package:bloc_clean_arch/quiz_app/offline/domain/quiz_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizRepoImplementation extends QuizRepo {
  // Firestore ref
  final CollectionReference questionCollection =
  FirebaseFirestore.instance.collection("quiz_questions");

 // final CollectionReference physicsQuestionCollectionRef = questionCollection.doc("");
  @override
  Future<void> checkAnswer() {
    // TODO: implement checkAnswer
    throw UnimplementedError();
  }

  @override
  Future<List<QuizModel>> fetchQuizQuestions({required String questionCategory}) async {

    Future<List<QuizModel>> PhysicsQuestions() async {
      print('Welcome to physics');
      List<QuizModel> physicsQuestions = [];
      physicsQuestions.add(QuizModel(
        question: "What is science?",
        allOptions: ['an art', 'a base', 'omo', 'a branch of knowledge'],
        correctOption: 'a branch of knowledge',
      ));
      physicsQuestions.add(QuizModel(
        question: "Who discovered gravity?",
        allOptions: ['albert einstein', 'tony stark', 'nheil bohr', 'issac newton'],
        correctOption: 'issac newton',
      ));

      physicsQuestions.add(QuizModel(
        question: "How many planets do we have?",
        allOptions: ['4', '5', '8', '9'],
        correctOption: '8',
      ));

      return physicsQuestions;
    }

    Future<List<QuizModel>> ChemistryQuestions() async {
      List<QuizModel> chemistryQuestions = [];
      chemistryQuestions.add(QuizModel(
        question: "(1) How many atoms do we have in the periodic table?",
        allOptions: ['0', '345', 'none'],
        correctOption: '225',
      ));
      chemistryQuestions.add(QuizModel(
        question: "(2) What is an ion?",
        allOptions: ['none', 'a substance', 'a cell'],
        correctOption: 'complexes',
      ));

      chemistryQuestions.add(QuizModel(
        question: "(3) what is a salt?",
        allOptions: ['a base', 'holla', 'inredient'],
        correctOption: 'a matter',
      ));

      return chemistryQuestions;
    }

    if (questionCategory == 'physics') {
      return PhysicsQuestions();
    } else if (questionCategory == 'chemistry') {
      return ChemistryQuestions();
    } else {
      throw Exception('Cant return an empty list');
    }
  }

  @override
  Future<void> nextQuestion() {
    // TODO: implement nextQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> previousQuestion() {
    // TODO: implement previousQuestion
    throw UnimplementedError();
  }

  @override
  Future<List<QuizModel>> fetchQuestionFromFireStore({required String questionCategory}) async{
    print("Loading Physics questions from  fire store");
    try{
      //Physics question fire store document ref
      DocumentSnapshot physicsQuestionSnapshot = await questionCollection.doc("physics_questions").get();

      //Chemistry question fire store document ref
      DocumentSnapshot chemistryQuestionSnapshot = await questionCollection.doc("chemistry_questions").get();


      if(questionCategory == "physics"){
        if(physicsQuestionSnapshot.exists){
          //Get the question list from the doc and map it to a list of QuizModel
          List<dynamic> physicsQuestionData = physicsQuestionSnapshot['questions'];
          List<QuizModel> physicsQuestionInModelForm = physicsQuestionData.map((data) => QuizModel.fromFireStoreMap(data)).toList();
          print("Physics questions loaded from  fire store successfully");
          print(physicsQuestionInModelForm[0].question);
          print(physicsQuestionInModelForm[0].question);
          print(physicsQuestionInModelForm[0].allOptions);
          print(physicsQuestionInModelForm[0].correctOption);
          return physicsQuestionInModelForm;
        }else{
          return [];
        }

      }else if(questionCategory == "chemistry"){
        if(chemistryQuestionSnapshot.exists){
          //Get the question list from the doc and map it to a list of QuizModel
          List<dynamic> chemistryQuestionData = chemistryQuestionSnapshot['questions'];
          List<QuizModel> chemistryQuestionInModelForm = chemistryQuestionData.map((data) => QuizModel.fromFireStoreMap(data)).toList();
          print("Chemistry questions loaded from  fire store successfully");
          print(chemistryQuestionInModelForm[0].question);
          print(chemistryQuestionInModelForm[0].question);
          print(chemistryQuestionInModelForm[0].allOptions);
          print(chemistryQuestionInModelForm[0].correctOption);
          return chemistryQuestionInModelForm;
        }else{
          return [];
        }

      }else{
        return [];
      }

    }catch(e){
      print("An error occurred fetching question from FB ${e}");
      return [];

    }

  }

  

  @override
  Future<void> loadQuestionsFromJsonLocally() async {
    try{
      String jsonData = await rootBundle.loadString('assets/questions.json');
      var parsedData = json.decode(jsonData);
      print(parsedData);
    }catch(e){
      print("An error occured loading questions${e}");
    }

  }

  @override
  Future<void> uploadQuestionsToFireStore({required String questionCategory,
    required String questions}) async {
    // Uploading questions
   // print("UploadingPhysicsQuestionsToFireStore...");

    try{
      if(questionCategory == "physics"){
        String jsonData = await rootBundle.loadString('assets/questions.json');
        List<dynamic> physicsQuestionList = json.decode(jsonData);

        //upload question list as a single document
        print("UploadingPhysicsQuestions...");
        await questionCollection.doc('physics_questions').set({
          'questions': physicsQuestionList

        });
        print(" physics questions uploaded successfully");
        Fluttertoast.showToast(
            msg: "physics questions uploaded successfully",
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);

      }else if(questionCategory == "chemistry"){
        String jsonData = questions;
        List<dynamic> chemistryQuestionList = json.decode(jsonData);

        //upload question list as a single document
        print("UploadingPhysicsQuestions...");
        await questionCollection.doc('chemistry_questions').set({
          'questions': chemistryQuestionList

        });
        print(" chemistry questions uploaded successfully");
        Fluttertoast.showToast(
            msg: "chemistry questions uploaded successfully",
            //  toastLength: Toast.LENGTH_LONG,
            // gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0);


      }


    }catch(e){
      print("Error uploading questions ${e}");

    }

  }


}
