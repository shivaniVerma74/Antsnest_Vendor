
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatelessWidget {
  String linkofpdf;
  PdfViewScreen({required this.linkofpdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(

                      child: SfPdfViewer.network(

                          'https://developmentalphawizz.com/antsnest/uploads/chats/${linkofpdf}')),
    );
  }
}
