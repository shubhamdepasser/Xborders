// To parse this JSON data, do
//
//     final unloadModule = unloadModuleFromJson(jsonString);

import 'dart:convert';

UnloadModule unloadModuleFromJson(String str) => UnloadModule.fromJson(json.decode(str));

String unloadModuleToJson(UnloadModule data) => json.encode(data.toJson());

class UnloadModule {
    UnloadModule();

    factory UnloadModule.fromJson(Map<String, dynamic> json) => UnloadModule(
    );

    Map<String, dynamic> toJson() => {
    };
}
