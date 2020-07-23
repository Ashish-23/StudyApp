


import 'dart:io';
import 'package:flutterapp3/widget/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, title, desc;
  File selectedImage;
  bool _isLoading = false;

  CrudMethods crudMethods = CrudMethods();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      //uploading image to firebase storage
      StorageReference firebaseStorageref = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final StorageUploadTask task = firebaseStorageref.putFile(selectedImage);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is URL $downloadUrl");

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "title": title,
        "desc": desc,
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              //uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.file_upload,color: Colors.black54,)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
        child: ListView(
            //  child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: selectedImage != null
                    ? Container(
                  height: 170,
                 // margin: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.cover,
                      )),
                )
                    : Container(
                  height: 170,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo,color: Colors.black54,size: 40,),
                      Text("Add Photo",style: TextStyle(color: Colors.black54,),)
                    ],
                  ),),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Author Name"),
                      onChanged: (val) {
                        authorName = val;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      onChanged: (val) {
                        title = val;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (val) {
                        desc = val;
                      },
                    )
                  ],
                ),
              ),
              Spacer(),
              SizedBox(height: 200,),
              GestureDetector(
                  onTap: (){
                    uploadBlog();
                  },
                  child: CreateButton(title: "Create Blog")),
              SizedBox(height: 10,)
            ],
        ),
      ),
          ),

    );
  }
}
