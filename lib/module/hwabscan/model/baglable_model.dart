// To parse this JSON data, do
//
//     final baglabelModule = baglabelModuleFromJson(jsonString);

import 'dart:convert';

BaglabelModule baglabelModuleFromJson(String str) => BaglabelModule.fromJson(json.decode(str));

String baglabelModuleToJson(BaglabelModule data) => json.encode(data.toJson());

class BaglabelModule {
    BaglabelModule({
        this.bagRowId,
        this.bagBarcode,
        this.bagDate,
        this.airlineNumber,
        this.flightNumber,
        this.flightDate,
        this.bagWeight,
        this.bagDetails,
        this.lastMilePort,
        this.logisticsName,
        this.isHavingBattery,
        this.isHavingBatteryLabel,
        this.clearanceType,
        this.clearanceTypeLabel,
        this.csbType,
        this.csbTypeLabel,
        this.countryName,
        this.isBagClosed,
        this.countrySortname,
        this.omDataArray,
        this.status,
    });

    String bagRowId;
    String bagBarcode;
    DateTime bagDate;
    String airlineNumber;
    String flightNumber;
    String flightDate;
    String bagWeight;
    String bagDetails;
    String lastMilePort;
    String logisticsName;
    String isHavingBattery;
    String isHavingBatteryLabel;
    String clearanceType;
    String clearanceTypeLabel;
    String csbType;
    String csbTypeLabel;
    String countryName;
    String isBagClosed;
    String countrySortname;
    List<OmDataArray> omDataArray;
    String status;

    factory BaglabelModule.fromJson(Map<String, dynamic> json) => BaglabelModule(
        bagRowId: json["bag_row_id"],
        bagBarcode: json["bag_barcode"],
        bagDate: DateTime.parse(json["bag_date"]),
        airlineNumber: json["airline_number"],
        flightNumber: json["flight_number"],
        flightDate: json["flight_date"],
        bagWeight: json["bag_weight"],
        bagDetails: json["bag_details"],
        lastMilePort: json["last_mile_port"],
        logisticsName: json["logistics_name"],
        isHavingBattery: json["is_having_battery"],
        isHavingBatteryLabel: json["is_having_battery_label"],
        clearanceType: json["clearance_type"],
        clearanceTypeLabel: json["clearance_type_label"],
        csbType: json["csb_type"],
        csbTypeLabel: json["csb_type_label"],
        countryName: json["country_name"],
        isBagClosed: json["is_bag_closed"],
        countrySortname: json["country_sortname"],
        omDataArray: List<OmDataArray>.from(json["om_data_array"].map((x) => OmDataArray.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "bag_row_id": bagRowId,
        "bag_barcode": bagBarcode,
        "bag_date": "${bagDate.year.toString().padLeft(4, '0')}-${bagDate.month.toString().padLeft(2, '0')}-${bagDate.day.toString().padLeft(2, '0')}",
        "airline_number": airlineNumber,
        "flight_number": flightNumber,
        "flight_date": flightDate,
        "bag_weight": bagWeight,
        "bag_details": bagDetails,
        "last_mile_port": lastMilePort,
        "logistics_name": logisticsName,
        "is_having_battery": isHavingBattery,
        "is_having_battery_label": isHavingBatteryLabel,
        "clearance_type": clearanceType,
        "clearance_type_label": clearanceTypeLabel,
        "csb_type": csbType,
        "csb_type_label": csbTypeLabel,
        "country_name": countryName,
        "is_bag_closed": isBagClosed,
        "country_sortname": countrySortname,
        "om_data_array": List<dynamic>.from(omDataArray.map((x) => x.toJson())),
        "status": status,
    };
}

class OmDataArray {
    OmDataArray({
        this.id,
        this.firstMileAwb,
        this.lastMileAwb,
        this.finalAwb,
        this.finalPhyWeight,
        this.bagId,
        this.tempBagId,
    });

    String id;
    String firstMileAwb;
    String lastMileAwb;
    String finalAwb;
    String finalPhyWeight;
    String bagId;
    String tempBagId;

    factory OmDataArray.fromJson(Map<String, dynamic> json) => OmDataArray(
        id: json["id"],
        firstMileAwb: json["first_mile_awb"],
        lastMileAwb: json["last_mile_awb"],
        finalAwb: json["final_awb"],
        finalPhyWeight: json["final_phy_weight"],
        bagId: json["bag_id"],
        tempBagId: json["temp_bag_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_mile_awb": firstMileAwb,
        "last_mile_awb": lastMileAwb,
        "final_awb": finalAwb,
        "final_phy_weight": finalPhyWeight,
        "bag_id": bagId,
        "temp_bag_id": tempBagId,
    };
}
