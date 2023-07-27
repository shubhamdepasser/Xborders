// import 'dart:io';

// import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
// import 'package:xborders/core/utilities/image_data/my_icons.dart';
// import 'package:xborders/core/utilities/variable.dart';
// import 'package:xborders/module/baglable/widget/pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

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
//         body: SilverAppBarCustom(
//             title: 'Preview',
//             titleWidget: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                       child: Text(Variable.Preview,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Color(0xff172b4d),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700))),
//                   SizedBox(width: 35),
//                   isStorage
//                       ? Container()
//                       : InkWell(
//                           onTap: () async =>
//                               await Base64Custom.saveFileToDir(file),
//                           borderRadius: BorderRadius.circular(5),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5)),
//                               padding: EdgeInsets.all(1.5),
//                               child: ImageItlscanner(
//                                   image: AppIconImage.downloadGreyIcon,
//                                   boxFit: BoxFit.fill,
//                                   height: 18,
//                                   width: 19)))
//                 ]),
//             child: Container(
//                 color: Color(0xFF525659),
//                 padding: EdgeInsets.only(right: 23, left: 23, top: 20),
//                 height: MediaQuery.of(context).size.height - 87,
//                 child: Column(children: [
//                   Expanded(
//                       child: PDFViewerDoc(
//                           document: doc,
//                           scrollDirection: Axis.vertical,
//                           showPicker: false)
//                           )
//                 ]))));
//   }
// }
