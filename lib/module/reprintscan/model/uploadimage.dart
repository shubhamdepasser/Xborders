// To parse this JSON data, do
//
//     final uploadimage = uploadimageFromJson(jsonString);

import 'dart:convert';

import 'package:xborders/module/reprintscan/model/UpdateWD.dart';

Uploadimage uploadimageFromJson(String str) =>
    Uploadimage.fromJson(json.decode(str));

String uploadimageToJson(Uploadimage data) => json.encode(data.toJson());

class Uploadimage {
  static UpdateWdModule value;

  Uploadimage({
    this.htmlMessage,
    this.fileExt,
    this.fileName,
    this.filePreview,
    this.status,
  });

  String htmlMessage;
  String fileExt;
  String fileName;
  String filePreview;
  String status;

  factory Uploadimage.fromJson(Map<String, dynamic> json) => Uploadimage(
        htmlMessage: json["html_message"],
        fileExt: json["file_ext"],
        fileName: json["file_name"],
        filePreview: json["file_preview"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "file_ext": fileExt,
        "file_name": fileName,
        "file_preview": filePreview,
        "status": status,
      };
}
