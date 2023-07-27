// To parse this JSON data, do
//
//     final submitModule = submitModuleFromJson(jsonString);

import 'dart:convert';

SubmitModule submitModuleFromJson(String str) => SubmitModule.fromJson(json.decode(str));

String submitModuleToJson(SubmitModule data) => json.encode(data.toJson());

class SubmitModule {
    SubmitModule({
        this.htmlMessage,
        this.status,
    });

    String htmlMessage;
    String status;

    factory SubmitModule.fromJson(Map<String, dynamic> json) => SubmitModule(
        htmlMessage: json["html_message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "status": status,
    };
}
