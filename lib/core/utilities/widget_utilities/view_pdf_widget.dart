// ignore_for_file: override_on_non_overriding_member

import 'dart:io';
import 'package:xborders/core/utilities/packages/pdf_viewer_doc.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
//import 'package:xborders/cor';

class ViewPdf {
  final PDFDocument doc;
  final bool isStorage;
  final File file;

  const ViewPdf({Key key, this.doc, this.isStorage, this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF525659),
        body: Container(
            color: Color(0xFF525659),
            padding: EdgeInsets.only(right: 23, left: 23, top: 20),
            height: MediaQuery.of(context).size.height - 87,
            child: Column(children: [
              Expanded(
                  child: PDFViewerDoc(
                      document: doc,
                      scrollDirection: Axis.vertical,
                      showPicker: false))
            ])));
  }
}
