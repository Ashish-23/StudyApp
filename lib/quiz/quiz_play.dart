import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/models/question_model.dart';
import 'package:flutterapp3/quiz/results.dart';
import 'package:flutterapp3/services/database.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'package:flutterapp3/widgets/quiz_play_widgets.dart';


class QuizPlay extends StatefulWidget {
  final String quizId;
  QuizPlay(this.quizId);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

/// Stream
Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    databaseService.getQuestionData(widget.quizId).then((value) {
      setState(() {
        questionSnaphot = value;
      });
        _notAttempted = questionSnaphot.documents.length;
        _correct = 0;
        _incorrect = 0;
        total = questionSnaphot.documents.length;
          isLoading = false;

        print("init don $total ${widget.quizId} ");
    }
     );

    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100), (x){
       // print("this is x $x");
        return [_correct, _incorrect] ;
      });
    }
  }


  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data["question"];

    /// shuffling the options
    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),

        centerTitle: true,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      )
          : SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              InfoHeader(
                length: questionSnaphot.documents.length,
              ),
              SizedBox(
                height: 10,
              ),
              questionSnaphot.documents == null
                  ? Container(
                child: Center(child: Text("No Data"),),
              )
                  : ListView.builder(
                  itemCount: questionSnaphot.documents.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return QuizPlayTile(
                      questionModel: getQuestionModelFromDatasnapshot(
                          questionSnaphot.documents[index]),
                      index: index,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot){
          return snapshot.hasData ? Container(
            height: 40,
            margin: EdgeInsets.only(left: 14),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                NoOfQuestionTile(
                  text: "Total",
                  number: widget.length,
                ),
               /* NoOfQuestionTile(
                  text: "Correct",
                  number: _correct,
                ),
                NoOfQuestionTile(
                  text: "Incorrect",
                  number: _incorrect,
                ),*/
                NoOfQuestionTile(
                  text: "NotAttempted",
                  number: _notAttempted,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Results(total: total,correct: _correct,incorrect: _incorrect,notattempted: _notAttempted,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: 30,width: 150,
                      child: Center(child: Text(" Result ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
               ),
                  ),
                )
              ],
            ),
          ) : Container();
        }
    );
  }
}


class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Text(
              "Q${widget.index + 1}). ${widget.questionModel.question}",
              style:
              TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted -1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A).",
              description: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "B).",
              description: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "C).",
              description: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "D)",
              description: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(thickness: 1,color: Colors.red[100],),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}