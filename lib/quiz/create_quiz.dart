import 'package:flutter/material.dart';
import 'package:flutterapp3/services/database.dart';
import 'file:///C:/Users/ambuj/flutter_project/flutter_app3/lib/quiz/add_question.dart';
import 'package:flutterapp3/widget/widget.dart';

import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {


  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  String quizId;


  createQuiz(){

    quizId = randomAlphaNumeric(16);
    if(_formKey.currentState.validate()){

      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizId" : quizId,
        "quizImgUrl" : quizImgUrl,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDesc
      };

      databaseService.addQuizData(quizData, quizId).then((value){
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) =>  AddQuestion(quizId)
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) =>
                val.isEmpty ? "Enter Quiz Image Url" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Image Url (Optional)"
                ),
                onChanged: (val){
                  quizImgUrl = val;
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Quiz Title" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Title"
                ),
                onChanged: (val){
                  quizTitle = val;
                },
              ),
              SizedBox(height: 5,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Quiz Description" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Description"
                ),
                onChanged: (val){
                  quizDesc = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: CreateButton(title: "Create Quiz",)
              ),
              SizedBox(
                height: 60,
              ),
            ],)
          ,),
      ),
    );
  }
}