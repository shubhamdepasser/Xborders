// To parse this JSON data, do
//
//     final printdocumentmodel = printdocumentmodelFromJson(jsonString);

import 'dart:convert';

Printdocumentmodel printdocumentmodelFromJson(String str) => Printdocumentmodel.fromJson(json.decode(str));

String printdocumentmodelToJson(Printdocumentmodel data) => json.encode(data.toJson());

class Printdocumentmodel {
    Printdocumentmodel({
        this.uploadPreview,
        this.status,
    });

    String uploadPreview;
    String status;

    factory Printdocumentmodel.fromJson(Map<String, dynamic> json) => Printdocumentmodel(
        uploadPreview: json["upload_preview"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "upload_preview": uploadPreview,
        "status": status,
    };
}
