// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:xborders/core/api/config/api_request.dart';
// import 'package:xborders/core/utilities/packages/pdf_viewer_doc.dart';
// // import 'package:xborders/core/utilities/package/pdf_viewer_doc.dart';
// import 'package:xborders/core/utilities/validation/utils.dart';
// import 'package:xborders/core/utilities/variable.dart';

// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:permission_handler/permission_handler.dart';


// class Base64Custom {
//   static String convertImageBase64(File file) {
//     return Base64Variable.image + convertToBase64(file);
//   }

//   static convertToBase64(File file) {
//     List<int> imageBytes = file.readAsBytesSync();
//     return base64Encode(imageBytes);
//   }

//   // static Future<String> encodeAssetImageBase64(String asset) async {
//   //   return Base64Variable.image + await encodeAssetImage(asset);
//   // }

//   // static Future<File> getImageFileFromAssets(String path) async {
//   //   final byteData = await rootBundle.load("assets/$path");

//   //   final file = File('${(await getTemporaryDirectory()).path}/$path');
//   //   await file.writeAsBytes(byteData.buffer
//   //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

//   //   return file;
//   // }

//   // static Future<String> encodeAssetImage(String asset) async {
//   //   ByteData bytes = await rootBundle.load(asset);
//   //   var buffer = bytes.buffer;
//   //   return base64.encode(Uint8List.view(buffer));
//   // }

//   // static encodeBase64PdfFile(File file) async {
//   //   return Base64Variable.pdf + convertToBase64(file);
//   // }

//   // static Future viewBase64PdfFile(String fileName) async {
//   //   try {
//   //     List<String> splitArray = fileName.split(Base64Variable.pdf);
//   //     if (splitArray[1].isNotEmpty) {
//   //       await decodeImage(splitArray[1]);
//   //     } else {
//   //       Utils.showMessage(message: 'File is corrupted');
//   //     }
//   //   } catch (e) {
//   //     Utils.showMessage(message: 'File is corrupted');
//   //   }
//   // }

//   // static Future decodeImage(String fileName) async {
//   //   Uint8List bytes = base64.decode(fileName);
//   //   String dir = (await getApplicationDocumentsDirectory()).path;
//   //   File file = File("$dir/" + 'xyz' + ".pdf");
//   //   await file.writeAsBytes(bytes);
//   //   await viewPdfFile(file: file, isStorage: false);
//   // }

//   static saveFileToDir(File file) async {
//     try {
//       String pdfName = "xyz.pdf";
//       Directory directory;
//       if (Platform.isAndroid) {
//         if (await _requestPermission(Permission.storage)) {
//           directory = await getExternalStorageDirectory();
//           String newPath = "";

//           List<String> paths = directory.path.split("/");
//           for (int x = 1; x < paths.length; x++) {
//             String folder = paths[x];
//             if (folder != "Android") {
//               newPath += "/" + folder;
//             } else {
//               break;
//             }
//           }
//           newPath = newPath + '/' + Variable.download_folder;
//           directory = Directory(newPath);
//           if (!await directory.exists()) {
//             await directory.create(recursive: true);
//           }
//           if (await directory.exists()) {
//             final File fileData = File(directory.path + "/$pdfName");
//             await fileData.writeAsBytes(await file.readAsBytes());
//            // Utils.shareFile(directory.path + "/$pdfName");
//             // Utils.showMessage(message: 'File saved in storage');
//           }
//         } else {
//          // Utils.showMessage(message: 'Allow permission to save file');
//         }
//       } else {
//         if (await _requestPermission(Permission.photos)) {
//           directory = await getTemporaryDirectory();
//           if (!await directory.exists()) {
//             await directory.create(recursive: true);
//           }
//           if (await directory.exists()) {
//             final File fileData = File(directory.path + "/$pdfName");
//             await fileData.writeAsBytes(await file.readAsBytes());
//           //  Utils.shareFile(directory.path + "/$pdfName");
//             // Utils.showMessage(message: 'File saved in storage');
//           }
//         } else {
//          // Utils.showMessage(message: 'Allow permission to save file');
//         }
//       }
//     } catch (e) {
//      // Utils.showMessage(message: 'Error occurred');
//     }
//   }

//   static Future<bool> _requestPermission(Permission permission) async {
//     if (await permission.isGranted) {
//       return true;
//     } else {
//       var result = await permission.request();
//       if (result == PermissionStatus.granted) {
//         return true;
//       }
//     }
//     return false;
//   }

//   static viewPdfUrl({String url, bool isStorage = false}) async {
//     Get.dialog(Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//            Center(child: CircularProgressIndicator())
//          // LoaderButton()
//           ]));
//     File file = await ApiRequest.downloadPdf(url);
//     print(url);
//     print('printeddddddddddddddddddddddddddddd');
//     Get.back();
//     Base64Custom.viewPdfFile(file: file, isStorage: isStorage);
//   }

//  static Future viewPdfFile({File file, bool isStorage = false}) async {
//     try {
//       PDFDocument doc = await PDFDocument.fromFile(file);
//       Get.to(() => ViewPdf(doc: doc, isStorage: isStorage, file: file));
//     } catch (e) {
//       print(e);
//       // Utils.showMessage(message: 'File is corrupted');
//     }
//   }
// }



// class ViewPdf extends StatelessWidget {
//   final PDFDocument doc;
//   final bool isStorage;
//   final File file;

//   const ViewPdf({Key key, this.doc, this.isStorage, this.file})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFF525659),
//         body: Container(
//                 color: Color(0xFF525659),
//                 padding: EdgeInsets.only(right: 23, left: 23, top: 20),
//                 height: MediaQuery.of(context).size.height - 87,
//                 child: Column(children: [
//                   Expanded(
//                       child: PDFViewerDoc(
//                           document: doc,
//                           scrollDirection: Axis.vertical,
//                           showPicker: false))
//                 ])));
//   }
// }


