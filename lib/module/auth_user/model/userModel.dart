// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.htmlMessage,
        this.status,
        this.userId,
        this.firstName,
        this.lastName,
        this.requestToken,
    });

    dynamic htmlMessage;
    String status;
    String userId;
    String firstName;
    String lastName;
    String requestToken;

    factory User.fromJson(Map<String, dynamic> json) => User(
        htmlMessage: json["html_message"],
        status: json["status"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        requestToken: json["request_token"],
    );

    Map<String, dynamic> toJson() => {
        "html_message": htmlMessage,
        "status": status,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "request_token": requestToken,
    };
}
