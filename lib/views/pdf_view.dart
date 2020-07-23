import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp3/services/ApiServiceProvider.dart';
import 'package:flutterapp3/views/pdf_home.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;


class PdfView extends StatefulWidget {
  String pdfUrl;
  PdfView({@required this.pdfUrl});

  @override
  _PdfViewState createState() => _PdfViewState(pdfUrl: pdfUrl);
}

class _PdfViewState extends State<PdfView> {
 String pdfUrl;
 _PdfViewState({this.pdfUrl});

  String localPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServiceProvider(pdfUrl: pdfUrl).loadPDF().then((value) {
      setState(() {
        localPath = value;
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
      ),



      body:  localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),

    );
  }
}



class ApiServiceProvider {
   final String pdfUrl;
  ApiServiceProvider({@required this.pdfUrl});

  Future<String> loadPDF() async {
    var response = await http.get(pdfUrl);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    print("ye h na ji $file.path");
    return file.path;
  }

}