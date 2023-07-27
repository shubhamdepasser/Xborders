// To parse this JSON data, do
//
//     final reprintscanModule = reprintscanModuleFromJson(jsonString);

import 'dart:convert';

ReprintscanModule reprintscanModuleFromJson(String str) => ReprintscanModule.fromJson(json.decode(str));

String reprintscanModuleToJson(ReprintscanModule data) => json.encode(data.toJson());

class ReprintscanModule {
    ReprintscanModule({
        this.printLabelLink,
        this.customerInvoiceFileName,
        this.omRowId,
        this.isDamage,
        this.ccSecurityCheck,
        this.userId,
        this.document1Status,
        this.document2Status,
        this.document2RejectRemark,
        this.totalInwardDoneCount,
        this.totalPrintLabelCount,
        this.reprintRemark,
        this.volWeight,
        this.finalPhyWeight,
        this.fileName1,
        this.fileName2,
        this.fileName3,
        this.upload1Preview,
        this.upload2Preview,
        this.upload3Preview,
        this.status,
    });

    String printLabelLink;
    String customerInvoiceFileName;
    String omRowId;
    String isDamage;
    String ccSecurityCheck;
    String userId;
    String document1Status;
    String document2Status;
    String document2RejectRemark;
    String totalInwardDoneCount;
    String totalPrintLabelCount;
    String reprintRemark;
    String volWeight;
    String finalPhyWeight;
    String fileName1;
    String fileName2;
    String fileName3;
    String upload1Preview;
    String upload2Preview;
    String upload3Preview;
    String status;

    factory ReprintscanModule.fromJson(Map<String, dynamic> json) => ReprintscanModule(
        printLabelLink: json["print_label_link"],
        customerInvoiceFileName: json["customer_invoice_file_name"],
        omRowId: json["om_row_id"],
        isDamage: json["is_damage"],
        ccSecurityCheck: json["cc_security_check"],
        userId: json["user_id"],
        document1Status: json["document_1_status"],
        document2Status: json["document_2_status"],
        document2RejectRemark: json["document_2_reject_remark"],
        totalInwardDoneCount: json["total_inward_done_count"],
        totalPrintLabelCount: json["total_print_label_count"],
        reprintRemark: json["reprint_remark"],
        volWeight: json["vol_weight"],
        finalPhyWeight: json["final_phy_weight"],
        fileName1: json["file_name1"],
        fileName2: json["file_name2"],
        fileName3: json["file_name3"],
        upload1Preview: json["upload1_preview"],
        upload2Preview: json["upload2_preview"],
        upload3Preview: json["upload3_preview"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "print_label_link": printLabelLink,
        "customer_invoice_file_name": customerInvoiceFileName,
        "om_row_id": omRowId,
        "is_damage": isDamage,
        "cc_security_check": ccSecurityCheck,
        "user_id": userId,
        "document_1_status": document1Status,
        "document_2_status": document2Status,
        "document_2_reject_remark": document2RejectRemark,
        "total_inward_done_count": totalInwardDoneCount,
        "total_print_label_count": totalPrintLabelCount,
        "reprint_remark": reprintRemark,
        "vol_weight": volWeight,
        "final_phy_weight": finalPhyWeight,
        "file_name1": fileName1,
        "file_name2": fileName2,
        "file_name3": fileName3,
        "upload1_preview": upload1Preview,
        "upload2_preview": upload2Preview,
        "upload3_preview": upload3Preview,
        "status": status,
    };
}
