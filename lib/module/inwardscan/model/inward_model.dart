import 'dart:convert';

InwardScan inwardScanFromJson(String str) =>
    InwardScan.fromJson(json.decode(str));

String inwardScanToJson(InwardScan data) => json.encode(data.toJson());

class InwardScan {
  InwardScan({
    this.htmlMessage,
    this.status,
  });

  String htmlMessage;
  String status;

  factory InwardScan.fromJson(Map<String, dynamic> json) => InwardScan(
        htmlMessage: json["html_message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "status": status,
      };
}
