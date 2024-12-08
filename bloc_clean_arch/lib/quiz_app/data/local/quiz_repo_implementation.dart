import 'dart:convert';
import 'dart:math';

import 'package:bloc_clean_arch/quiz_app/domain/quiz_model.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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
  Future<List<QuizModel>> fetchQuizQuestions({required String category}) async {

    Future<List<QuizModel>> PhysicsQuestions() async {
      print('Welcome to physics');
      List<QuizModel> physicsQuestions = [];
      physicsQuestions.add(QuizModel(
        question: "(1) What is science?",
        allOptions: ['an art', 'a base', 'omo', 'a branch of knowledge'],
        correctOption: 'a branch of knowledge',
      ));
      physicsQuestions.add(QuizModel(
        question: "(2) Who discovered gravity?",
        allOptions: ['albert einstein', 'tony stark', 'nheil bohr', 'issac newton'],
        correctOption: 'issac newton',
      ));

      physicsQuestions.add(QuizModel(
        question: "(3) How many planets do we have?",
        allOptions: ['4', '5', '8', '9'],
        correctOption: '9',
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

    if (category == 'physics') {
      return PhysicsQuestions();
    } else if (category == 'chemistry') {
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
  Future<List<QuizModel>> fetchPhysicsQuestionFromFireStore() async{
    print("Loading Physics questions from  fire store");
    try{
      //Physics question fire store document ref
      DocumentSnapshot physicsQuestionSnapshot = await questionCollection.doc("physics_questions").get();
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

    }catch(e){
      print("An error occureed fetching question from FB ${e}");
      return [];

    }

  }

  @override
  Future<void> uploadPhysicsQuestionsToFireStore() async {
    // Uploading questions
    print("UploadingPhysicsQuestionsToFireStore...");

    try{
     String jsonData = await rootBundle.loadString('assets/questions.json');
     List<dynamic> physicsQuestionList = json.decode(jsonData);

     //upload question list as a single document
     print("UploadingPhysicsQuestions...");
     await questionCollection.doc('physics_questions').set({
       'questions': physicsQuestionList

     });
     print("Questions added successfully");

   }catch(e){
     print("Error uploading questions ${e}");

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


}
