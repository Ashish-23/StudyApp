import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionTile(
      {this.description, this.correctAnswer, this.option, this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24)
      ),
     // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 3),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.only(left: 20),

        height: 45,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.optionSelected == widget.description
                    ? widget.description == widget.correctAnswer
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7)
                    : Colors.black26,
                width: 1.0),
            color: widget.optionSelected == widget.description
                ? widget.description == widget.correctAnswer
                ? Colors.green.withOpacity(0.8)
                : Colors.red.withOpacity(0.7)
                : Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Row(
          children: [
            Container(

              child: Text(
                widget.option,
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.white
                      : Colors.black54,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(widget.description, style: TextStyle(
                fontSize: 14,
              color: widget.optionSelected == widget.description
                ? Colors.white
                : Colors.black54,
            ),)
          ],
        ),
      ),
    );
  }
}


class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({this.text, this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14)
                ),
                color: Colors.blue
            ),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                color: Colors.black54
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
