import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/quiz/quiz_home.dart';
import 'package:flutterapp3/services/crud.dart';
import 'package:flutterapp3/views/menu_page.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'package:flutterapp3/views/pdf_home.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();
  Stream blogsStream;

  Widget blogsList(){
    return Container(
        color: Colors.white,
        child:  blogsStream != null ?
        StreamBuilder<dynamic>(
            stream: blogsStream,
            builder: (context, snapshot){
              if(snapshot.data == null) return CircularProgressIndicator();
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  itemCount: snapshot.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          height: 10,

                        ),
                        BlogsTile(
                          authorName: snapshot.data.documents[index].data["authorName"],
                          title: snapshot.data.documents[index].data["title"],
                          description: snapshot.data.documents[index].data["desc"],
                          imgUrl: snapshot.data.documents[index].data["imgUrl"],
                        ),
                      ],
                    );
                  });
            })
            :Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),)
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudMethods.getData().then((result){
      setState(() {
        blogsStream=result;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xFF012130),
          elevation: 20.0,
          title:Center(child: AppLogo()),
          bottomOpacity: 1,
          bottom: TabBar(tabs: [
            Tab(icon:Icon(Icons.home)),
            Tab(icon: Icon(Icons.assignment),),
            Tab(icon: Icon(Icons.library_books),),
          ]),
          actions: [Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.settings),
          )],
        ),
        drawer: MenuPage(),

        body: TabBarView(children:[
          blogsList(),
          QuizHome(),
          PdfHome(),
        ]),
        floatingActionButton: Container(

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[

                ]
            ),
          ),
        ),
      ),
    );
  }
}


class BlogsTile extends StatelessWidget {

  final String imgUrl,title,description,authorName;
  BlogsTile({@required this.imgUrl,@required this.title,
    @required this.description,@required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      height: 600,//MediaQuery.of(context).size.height,
      child: Stack(
          children:<Widget>[
            Container(
              height: 600,
              decoration: BoxDecoration(color: Color(0xFF557588).withOpacity(0.3),
                  border: Border.all(color: Colors.black54,width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
            ),


            Column(
              children: [
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54,width:1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(imageUrl:imgUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                //Container(height: 50,color: Colors.red,)
               Padding(
                 padding: const EdgeInsets.fromLTRB(5,5,0, 5),
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(authorName,style: TextStyle(color: Colors.black54,fontSize:20,fontWeight: FontWeight.w600,),)),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(title,style: TextStyle(color: Colors.black,fontSize:20,fontWeight: FontWeight.w500),)),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(description,style: TextStyle(color: Colors.black,fontSize:15),)),
                      ]
                  ),),
               ),
              ],
            ),

            Container(
              height: 600, //MediaQuery.of(context).size.height,
              //height: 170,
              decoration: BoxDecoration(color: Colors.transparent,
                  border: Border.all(color: Colors.black54,width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
            ),

          ]
      ),
    );
  }
}


