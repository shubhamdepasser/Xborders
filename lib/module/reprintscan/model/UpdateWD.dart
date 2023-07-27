// To parse this JSON data, do
//
//     final updateWdModule = updateWdModuleFromJson(jsonString);

import 'dart:convert';

UpdateWdModule updateWdModuleFromJson(String str) => UpdateWdModule.fromJson(json.decode(str));

String updateWdModuleToJson(UpdateWdModule data) => json.encode(data.toJson());

class UpdateWdModule {
    UpdateWdModule({
        this.htmlMessage,
        this.status,
    });

    String htmlMessage;
    String status;

    factory UpdateWdModule.fromJson(Map<String, dynamic> json) => UpdateWdModule(
        htmlMessage: json["html_message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "status": status,
    };
}
