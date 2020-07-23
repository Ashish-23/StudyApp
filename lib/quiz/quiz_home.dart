import 'package:flutter/material.dart';
import 'package:flutterapp3/services/database.dart';
import 'file:///C:/Users/ambuj/flutter_project/flutter_app3/lib/quiz/quiz_play.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'create_quiz.dart';

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      child:quizStream!=null?
      StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return QuizTile(
                  noOfQuestions: snapshot.data.documents.length,
                  imageUrl:
                  snapshot.data.documents[index].data['quizImgUrl'],
                  title:
                  snapshot.data.documents[index].data['quizTitle'],
                  description:
                  snapshot.data.documents[index].data['quizDesc'],
                  quizId: snapshot.data.documents[index].data["quizId"],
                );
              });
        },
      ):Container(
        child: CircularProgressIndicator(),
      )
    );
  }

  @override
  void initState() {

    super.initState();
    databaseService.getQuizData().then((value) {

      setState(() {
        quizStream = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     /* appBar: AppBar(
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),*/
      body: quizList(),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),*/
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, quizId, description;
  final int noOfQuestions;

  QuizTile(
      {@required this.title,
        @required this.imageUrl,
        @required this.description,
        @required this.quizId,
        @required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => QuizPlay(quizId)
        ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 170,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
