import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/quiz/create_quiz.dart';
import 'package:flutterapp3/views/creat_blog.dart';
import 'package:flutterapp3/office_work/create_pdf.dart';

class OfficePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCCCCCC),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: ListView(
            //
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>CreateQuiz()));
                },
                child: Buttom(title: "Creat Quiz",),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>CreateBlog()));
                },
                child: Buttom(title: "Creat Blog",),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>CreatePdf()));
                },
                child: Buttom(title: "Creat PDF",),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Buttom(title: "jhjgjk",),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}

class Buttom extends StatelessWidget {
  final String title;
  Buttom({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      height: 80,
      //width: MediaQuery.of(context).size.width,
      color: Color(0xFF66AA66),
      child: Text(title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white),
    ));
  }
}






