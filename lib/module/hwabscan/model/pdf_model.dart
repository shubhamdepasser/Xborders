// To parse this JSON data, do
//
//     final pdfModule = pdfModuleFromJson(jsonString);

import 'dart:convert';

PdfModule pdfModuleFromJson(String str) => PdfModule.fromJson(json.decode(str));

String pdfModuleToJson(PdfModule data) => json.encode(data.toJson());

class PdfModule {
    PdfModule({
        this.bagLabelS3Url,
        this.status,
    });

    String bagLabelS3Url;
    String status;

    factory PdfModule.fromJson(Map<String, dynamic> json) => PdfModule(
        bagLabelS3Url: json["bag_label_s3_url"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "bag_label_s3_url": bagLabelS3Url,
        "status": status,
    };
}
