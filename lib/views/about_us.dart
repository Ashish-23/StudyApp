import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      //backgroundColor: Colors.white60,
        /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation:0.0,
          brightness: Brightness.light,
          title: AppLogo()
        ),*/
        body:Stack( children: <Widget>[Center(
          child:new  CachedNetworkImage(imageUrl: "https://i.pinimg.com/236x/e6/bd/74/e6bd7458c4083f60dbb7beff47e5f9c9.jpg",
            fit: BoxFit.cover,
          width: size.width,
              height: size.height,)
        ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                CircleAvatar(
                 // child: CachedNetworkImage(imageUrl: "https://i.pinimg.com/236x/e6/bd/74/e6bd7458c4083f60dbb7beff47e5f9c9.jpg",
                 // height: size.height,
                 // width: size.width,),
                 backgroundImage: NetworkImage(
                   "https://dochub.com/ambujashish15/4DeM0oWKm89kQ7xRXyLgP3/img-20170908-224235-jpg",
                 ),
                  radius: 70.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'DEVELOPER:-',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,color: Colors.black),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Ashish Kumar',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,color: Colors.black),
                ),
                Text(
                  '(3rd year student of NIT Patna)',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,color: Colors.black),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: Colors.red,
                  endIndent: 80.0,
                  indent: 80.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,20, 30, 20),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.call),
                      title: Text('+91 7992397518'),
                    ),
                    elevation: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,0, 30, 0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.mail),
                      title: Text('ambujashish15@gmail.com'),
                    ),
                    elevation: 20,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

