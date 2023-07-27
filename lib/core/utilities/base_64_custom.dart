import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'loading.dart';
import 'packages/pdf_viewer_doc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
//import 'package:web_browser/web_browser.dart';
//import 'dart:async';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Base64Custom {
  static String convertImageBase64(File file) {
    return Base64Variable.image + convertToBase64(file);
  }

  static convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static Future<String> encodeAssetImageBase64(String asset) async {
    return Base64Variable.image + await encodeAssetImage(asset);
  }

  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load("assets/$path");
  }

  static Future<String> encodeAssetImage(String asset) async {
    ByteData bytes = await rootBundle.load(asset);
    var buffer = bytes.buffer;
    return base64.encode(Uint8List.view(buffer));
  }

  static encodeBase64PdfFile(File file) async {
    return Base64Variable.pdf + convertToBase64(file);
  }

  static Future viewBase64PdfFile(String fileName) async {
    try {
      List<String> splitArray = fileName.split(Base64Variable.pdf);
      if (splitArray[1].isNotEmpty) {
        await decodeImage(splitArray[1]);
      } else {
        //Utils.showMessage(message: 'File is corrupted');
      }
    } catch (e) {
      //Utils.showMessage(message: 'File is corrupted');
    }
  }

  static Future decodeImage(String fileName) async {
    Uint8List bytes = base64.decode(fileName);
  }

  static saveFileToDir(File file) async {
    try {
      String pdfName = "xyz.pdf";
      Directory directory;
      if (Platform.isAndroid) {
      } else {}
    } catch (e) {
      //Utils.showMessage(message: 'Error occurred');
    }
  }

  // static Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  static viewPdfUrl({String url, bool isStorage = false}) async {
    // Get.dialog(Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [LoaderButton()]));
    //File file = await ApiRequest.downloadPdf(url);
    //Get.back();
    //Base64Custom.viewPdfFile(url: url, file: file, isStorage: isStorage);
    Get.to(() => Openpdf(url: url, isStorage: isStorage));
  }

  static Future viewPdfFile(
      {String url, File file, bool isStorage = false}) async {
    try {
      PDFDocument doc = await PDFDocument.fromFile(file);
      //Get.to(() => ViewPdf(doc: doc, isStorage: isStorage, file: file));
      Get.to(() => Openpdf(url: url, isStorage: isStorage, file: file));
      //Get.toEnd(() => ViewPdf(doc: doc, isStorage: isStorage, file: file));
    } catch (e) {
      //PDFDocument _pdf = await PDFDocument.fromURL(url);
      Get.to(() => Openpdf(url: url, isStorage: isStorage, file: file));

      Utils.showMessage(message: e.toString());
    }
  }
}

class ViewPdf extends StatelessWidget {
  final PDFDocument doc;
  final bool isStorage;
  final File file;

  const ViewPdf({Key key, this.doc, this.isStorage, this.file})
      : super(key: key);

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

class Openpdf extends StatelessWidget {
  final bool isStorage;
  final String url;
  final File file;

  Openpdf({Key key, this.url, this.isStorage, this.file}) : super(key: key);
  PdfViewerController _pdfViewerController = PdfViewerController();

  final double progress = 0;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // SizedBox(
          //   height: 9,
          // ),
          // Row(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.only(left: 10),
          //       child: IconButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           icon: Icon(
          //             Icons.arrow_back,
          //             size: 24,
          //             color: Colors.black,
          //           )),
          //     ),
          //     Container(
          //       padding: EdgeInsets.only(left: 10),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 13,
          ),
          SfPdfViewer.network(
            url,
            key: _pdfViewerKey,
            controller: _pdfViewerController,
            onDocumentLoaded: (details) {
              //Get.back();
            },
            onPageChanged: (details) {
              //Get.back();
            },
          )
        ],
      ),
    );
  }
}
