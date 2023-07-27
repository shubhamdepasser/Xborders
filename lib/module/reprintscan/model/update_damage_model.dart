// To parse this JSON data, do
//
//     final updatedamagemodel = updatedamagemodelFromJson(jsonString);

import 'dart:convert';

Updatedamagemodel updatedamagemodelFromJson(String str) => Updatedamagemodel.fromJson(json.decode(str));

String updatedamagemodelToJson(Updatedamagemodel data) => json.encode(data.toJson());

class Updatedamagemodel {
    Updatedamagemodel({
        this.printLabelLink,
        this.htmlMessage,
        this.status,
    });

    String printLabelLink;
    String htmlMessage;
    String status;

    factory Updatedamagemodel.fromJson(Map<String, dynamic> json) => Updatedamagemodel(
        printLabelLink: json["print_label_link"],
        htmlMessage: json["html_message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "print_label_link": printLabelLink,
        "html_message": htmlMessage,
        "status": status,
    };
}
