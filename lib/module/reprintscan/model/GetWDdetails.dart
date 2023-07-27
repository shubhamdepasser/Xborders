import 'dart:convert';

GetWDdetailsModule getWDdetailsModuleFromJson(String str) => GetWDdetailsModule.fromJson(json.decode(str));

String getWDdetailsModuleToJson(GetWDdetailsModule data) => json.encode(data.toJson());

class GetWDdetailsModule {
    GetWDdetailsModule({
        this.rowId,
        this.actualWeight,
        this.revisedWeight,
        this.fileName1,
        this.fileName2,
        this.fileName3,
        this.upload1Preview,
        this.upload2Preview,
        this.upload3Preview,
        this.count,
        this.status,
    });

    String rowId;
    String actualWeight;
    String revisedWeight;
    String fileName1;
    String fileName2;
    String fileName3;
    String upload1Preview;
    String upload2Preview;
    String upload3Preview;
    int count;
    String status;

    factory GetWDdetailsModule.fromJson(Map<String, dynamic> json) => GetWDdetailsModule(
        rowId: json["row_id"],
        actualWeight: json["actual_weight"],
        revisedWeight: json["revised_weight"],
        fileName1: json["file_name1"],
        fileName2: json["file_name2"],
        fileName3: json["file_name3"],
        upload1Preview: json["upload1_preview"],
        upload2Preview: json["upload2_preview"],
        upload3Preview: json["upload3_preview"],
        count: json["count"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "row_id": rowId,
        "actual_weight": actualWeight,
        "revised_weight": revisedWeight,
        "file_name1": fileName1,
        "file_name2": fileName2,
        "file_name3": fileName3,
        "upload1_preview": upload1Preview,
        "upload2_preview": upload2Preview,
        "upload3_preview": upload3Preview,
        "count": count,
        "status": status,
    };
}
