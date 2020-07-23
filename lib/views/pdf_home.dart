import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/services/database.dart';
import 'package:flutterapp3/views/pdf_view.dart';

class PdfHome extends StatefulWidget {
  @override
  _PdfHomeState createState() => _PdfHomeState();
}

class _PdfHomeState extends State<PdfHome> {
  DatabaseService _databaseService= DatabaseService();
  Stream pdfStream;
  bool _loading=false;

  Widget pdfList() {
    return Container(
        child:pdfStream!=null?
        StreamBuilder(
          stream: pdfStream,
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container()
                : GridView.builder(
              itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
              itemBuilder: (BuildContext context, int index){
                  return PdfTile(
                    title:snapshot.data.documents[index].data["title"] ,
                    desc: snapshot.data.documents[index].data["desc"],
                    pdfUrl: snapshot.data.documents[index].data["pdfUrl"],

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
    // TODO: implement initState
    super.initState();
    _databaseService.getPdfData().then((result){
      setState(() {
        pdfStream=result;
      });


    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x057A8AAE),
      body: pdfList(),

    );
  }
}


class PdfTile extends StatelessWidget {
  String title,desc,pdfUrl,localPath;
   PdfTile({@required this.title,this.desc,@required this.pdfUrl });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>   PdfView(pdfUrl: pdfUrl,),));
      },
      child: Container(
        height: 200,
       padding: EdgeInsets.all(05),
       
        child: ClipRRect(

          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [

                  CachedNetworkImage(imageUrl:"https://www.appdemovideos.com/wp-content/uploads/2017/02/8-SplitShire-1024x683.jpg",
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600,),),
                    Text(desc,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600,),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



