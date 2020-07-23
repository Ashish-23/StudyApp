import 'package:flutterapp3/office_work/office_home.dart';
import 'package:flutterapp3/quiz/quiz_home.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/views/about_us.dart';
import 'package:flutterapp3/views/pdf_home.dart';
import 'package:flutterapp3/views/home.dart';
import 'package:flutterapp3/widget/widget.dart';
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(

      child: SafeArea(

          child: ListView(
            children: <Widget>[
              Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppLogo(),
                  )),
              Divider(
                thickness: 1.0,
                color: Colors.black45,
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
                child: menuTile(menuText: "Current Affairs")
              ),

               GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizHome()));},
                child: menuTile(menuText: "Quiz")
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfHome()));},
                child: menuTile(menuText: "PDF")
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));},
                child: menuTile(menuText: "About Us")
              ),

              GestureDetector(
                onTap: (){},
                child: menuTile(menuText: "Privecy Policy")
              ),
              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>OfficePage()));},
                child: menuTile(menuText: "Office Work")
              ),

              GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
                child: menuTile(menuText: "Cancle")
              ),
              /* ListTile(
                      leading:Icon(Icons.cancel,size: 30,),
                      title:Text('Cancle',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                      onTap: ()=>Navigator.of(context).pop(),
                    ),*/
              Divider(
                color: Colors.red[100],
              )
            ],
          )),
    );
  }
}
class menuTile extends StatelessWidget {
  String menuText;
  menuTile({@required this.menuText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(5, 3, 5, 0),
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_forward), onPressed: null),
          Text(
            menuText,
            style:
            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black54),
          ),
        ],
      ),
    ) ;
  }
}


