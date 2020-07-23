import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/services/database.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'package:random_string/random_string.dart';

class CreatePdf extends StatefulWidget {
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdf> {
  DatabaseService _databaseService= DatabaseService();
  final _formKey = GlobalKey<FormState>();
  String _title,_desc;
  File selectedPdf;
  bool _isloading=false;

  Future getPdf()async{
    File file = await FilePicker.getFile(type: FileType.custom);
   // var pdf=await FilePicker.getFilePath(type: FileType.custom, allowedExtensions: ['svg', 'pdf']);
    setState(() {
      if(file!=null) {
        selectedPdf = file;
      }else{
        Container(color:Colors.red);
      }
    });
  }

   uploadPdf()async{
    if(selectedPdf!=null){


    setState(() {
      _isloading=true;
    });
   final StorageReference firebasestorageref=FirebaseStorage.instance
    .ref()
    .child("pdf")
    .child("${randomAlphaNumeric(8)}.pdf");
    final StorageUploadTask uploadtask= firebasestorageref.putFile(selectedPdf);
    var downloadpdfUrl= await (await uploadtask.onComplete).ref.getDownloadURL();
    print("this is downloaded pdf url $downloadpdfUrl");

    Map<String,String> pdfMap={
      "pdfUrl": downloadpdfUrl,
      "title":_title,
      "desc": _desc,
    };
    _databaseService.addPDFData(pdfMap).then((value){
      Navigator.pop(context);
    });}else{}

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black54,),
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor:Colors.transparent,
        brightness: Brightness.light,
      ),

      body:_isloading?Container(child: CircularProgressIndicator(),): Form(
        key: _formKey,
        child: Container(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: ListView(
                 children:  [
                   GestureDetector(
                     onTap: (){
                      getPdf();
                     },
                     child:selectedPdf!=null?Container(
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(6),
                         child: Icon(Icons.picture_as_pdf,size: 100,),
                       ),

                     ):
                      Container(
                       height: 170,
                       width: MediaQuery.of(context).size.width,
                       color: Colors.black54,
                      child: Center(child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_box,size: 40,color: Colors.white,),
                          Text("Add PDF",style: TextStyle(color: Colors.white),),
                        ],
                      )),

                     ),
                   ),
                   SizedBox(height: 8,),
                   Container(
                     child: Column(
                       children: [
                         TextFormField(
                           validator:(val)=>val.isEmpty? "enter title":null,
                           decoration: InputDecoration(hintText: "Title"),
                         onChanged: (val){
                           _title=val;
                         },
                         ),
                         TextFormField(
                           validator: (val)=> val.isEmpty?"Enter Describtion":null,
                           decoration: InputDecoration(hintText: "Describtion"),
                           onChanged: (val){
                             _desc=val;
                           },
                         ),

                       ],
                     ),
                   ),

                   //SizedBox(height: 100,),
                   Spacer(),
                   GestureDetector(
                       onTap: (){
                         uploadPdf();
                       },
                       child: CreateButton(title: "Create PDF")),
                   SizedBox(height: 10,)
                 ],
                 ),
             ),
             ),
      ),


    );
  }
}
