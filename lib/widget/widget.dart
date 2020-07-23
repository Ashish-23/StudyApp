import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 25
        ),
        children: <TextSpan>[
          TextSpan(text: 'Study', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.grey)),
          TextSpan(text: 'Time', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.deepOrangeAccent)),
        ],
      ),
    );
  }
}
class CreateButton extends StatelessWidget {
  String title;
  CreateButton({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width-80,
      padding: EdgeInsets.symmetric(
          horizontal: 34, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: Colors.white),
      ),
    );
  }
}
