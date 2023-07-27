import 'dart:convert';
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
// To parse this JSON data, do
//
//     final createBagModule = createBagModuleFromJson(jsonString);
 
 
// To parse this JSON data, do
//
//     final hwabModule = hwabModuleFromJson(jsonString);



HwabModule hwabModuleFromJson(String str) => HwabModule.fromJson(json.decode(str));

String hwabModuleToJson(HwabModule data) => json.encode(data.toJson());

class HwabModule {
    HwabModule({
        this.status,
        this.isShowModal,
        this.allBmDataArray,
        this.tempBagId,
        this.bagId,
        this.bagWeight,
        this.finalPhyWeight,
        this.omRowId,
        this.isNewBag,
        this.isBagExceeded,
    });
    String status;
    int isShowModal;
    List<AllBmDataArray> allBmDataArray;
    String tempBagId;
    String bagId;
    int bagWeight;
    String finalPhyWeight;
    String omRowId;
    int isNewBag;
    int isBagExceeded;

    factory HwabModule.fromJson(Map<String, dynamic> json) => HwabModule(
        status: json["status"],
        isShowModal: json["is_show_modal"],
        allBmDataArray: List<AllBmDataArray>.from(json["all_bm_data_array"].map((x) => AllBmDataArray.fromJson(x))),
        tempBagId: json["temp_bag_id"],
        bagId: json["bag_id"],
        bagWeight: json["bag_weight"],
        finalPhyWeight: json["final_phy_weight"],
        omRowId: json["om_row_id"],
        isNewBag: json["is_new_bag"],
        isBagExceeded: json["is_bag_exceeded"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "is_show_modal": isShowModal,
        "all_bm_data_array": List<dynamic>.from(allBmDataArray.map((x) => x.toJson())),
        "temp_bag_id": tempBagId,
        "bag_id": bagId,
        "bag_weight": bagWeight,
        "final_phy_weight": finalPhyWeight,
        "om_row_id": omRowId,
        "is_new_bag": isNewBag,
        "is_bag_exceeded": isBagExceeded,
    };
}

class AllBmDataArray {
    AllBmDataArray({
        this.id,
        this.dcId,
        this.bagBarcode,
        this.bagDate,
        this.airlineNumber,
        this.flightNumber,
        this.flightDate,
        this.bagWeight,
        this.bagDetails,
        this.isMoveFromWarehouse,
        this.isXrayDone,
        this.isCustomClearDone,
        this.isSecurityClearanceDone,
        this.isAirliftDone,
        this.isBagClosed,
        this.movedDateTime,
        this.xrayDateTime,
        this.customClearDateTime,
        this.securityClearanceDateTime,
        this.xrayHoldDateTime,
        this.customClearHoldDateTime,
        this.securityClearanceHoldDateTime,
        this.airliftDateTime,
        this.bagClosedDateTime,
        this.lastMilePort,
        this.lastMileLogisticsId,
        this.countryId,
        this.isHavingBattery,
        this.clearanceType,
        this.csbType,
        this.mawbFileName,
        this.createdDate,
        this.updatedDate,
        this.status,
        this.isDeleted,
    });

    String id;
    String dcId;
    String bagBarcode;
    DateTime bagDate;
    String airlineNumber;
    String flightNumber;
    String flightDate;
    String bagWeight;
    String bagDetails;
    String isMoveFromWarehouse;
    String isXrayDone;
    String isCustomClearDone;
    String isSecurityClearanceDone;
    String isAirliftDone;
    String isBagClosed;
    String movedDateTime;
    String xrayDateTime;
    String customClearDateTime;
    String securityClearanceDateTime;
    String xrayHoldDateTime;
    String customClearHoldDateTime;
    String securityClearanceHoldDateTime;
    String airliftDateTime;
    String bagClosedDateTime;
    String lastMilePort;
    String lastMileLogisticsId;
    String countryId;
    String isHavingBattery;
    String clearanceType;
    String csbType;
    String mawbFileName;
    DateTime createdDate;
    String updatedDate;
    String status;
    String isDeleted;

    factory AllBmDataArray.fromJson(Map<String, dynamic> json) => AllBmDataArray(
        id: json["id"],
        dcId: json["dc_id"],
        bagBarcode: json["bag_barcode"],
        bagDate: DateTime.parse(json["bag_date"]),
        airlineNumber: json["airline_number"],
        flightNumber: json["flight_number"],
        flightDate: json["flight_date"],
        bagWeight: json["bag_weight"],
        bagDetails: json["bag_details"],
        isMoveFromWarehouse: json["is_move_from_warehouse"],
        isXrayDone: json["is_xray_done"],
        isCustomClearDone: json["is_custom_clear_done"],
        isSecurityClearanceDone: json["is_security_clearance_done"],
        isAirliftDone: json["is_airlift_done"],
        isBagClosed: json["is_bag_closed"],
        movedDateTime: json["moved_date_time"],
        xrayDateTime: json["xray_date_time"],
        customClearDateTime: json["custom_clear_date_time"],
        securityClearanceDateTime: json["security_clearance_date_time"],
        xrayHoldDateTime: json["xray_hold_date_time"],
        customClearHoldDateTime: json["custom_clear_hold_date_time"],
        securityClearanceHoldDateTime: json["security_clearance_hold_date_time"],
        airliftDateTime: json["airlift_date_time"],
        bagClosedDateTime: json["bag_closed_date_time"],
        lastMilePort: json["last_mile_port"],
        lastMileLogisticsId: json["last_mile_logistics_id"],
        countryId: json["country_id"],
        isHavingBattery: json["is_having_battery"],
        clearanceType: json["clearance_type"],
        csbType: json["csb_type"],
        mawbFileName: json["mawb_file_name"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedDate: json["updated_date"],
        status: json["status"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dc_id": dcId,
        "bag_barcode": bagBarcode,
        "bag_date": "${bagDate.year.toString().padLeft(4, '0')}-${bagDate.month.toString().padLeft(2, '0')}-${bagDate.day.toString().padLeft(2, '0')}",
        "airline_number": airlineNumber,
        "flight_number": flightNumber,
        "flight_date": flightDate,
        "bag_weight": bagWeight,
        "bag_details": bagDetails,
        "is_move_from_warehouse": isMoveFromWarehouse,
        "is_xray_done": isXrayDone,
        "is_custom_clear_done": isCustomClearDone,
        "is_security_clearance_done": isSecurityClearanceDone,
        "is_airlift_done": isAirliftDone,
        "is_bag_closed": isBagClosed,
        "moved_date_time": movedDateTime,
        "xray_date_time": xrayDateTime,
        "custom_clear_date_time": customClearDateTime,
        "security_clearance_date_time": securityClearanceDateTime,
        "xray_hold_date_time": xrayHoldDateTime,
        "custom_clear_hold_date_time": customClearHoldDateTime,
        "security_clearance_hold_date_time": securityClearanceHoldDateTime,
        "airlift_date_time": airliftDateTime,
        "bag_closed_date_time": bagClosedDateTime,
        "last_mile_port": lastMilePort,
        "last_mile_logistics_id": lastMileLogisticsId,
        "country_id": countryId,
        "is_having_battery": isHavingBattery,
        "clearance_type": clearanceType,
        "csb_type": csbType,
        "mawb_file_name": mawbFileName,
        "created_date": createdDate.toIso8601String(),
        "updated_date": updatedDate,
        "status": status,
        "is_deleted": isDeleted,
    };
}
