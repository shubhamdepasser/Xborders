import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/module/hwabscan/model/baglable_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BagDetailController extends GetxController {
  var userModel = BaglabelModule().obs;
  var isLoading = true.obs;
  GetStorage storage = GetStorage();
  String Baglable = 'Baglable';
  var statusCode = 0.obs;
  RxInt log2 = 0.obs;
  TextEditingController bagdetail = TextEditingController();
  TextEditingController airlinenumb = TextEditingController();
  var country_sortname = ''.obs;
  var last_mile_port = ''.obs;
  var logistics_name = ''.obs;
  var clearance_type_label = ''.obs;
  var is_having_battery_label = ''.obs;
  var csb_type_label = ''.obs;
  var bag_barcode = ''.obs;
  var bag_weight = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  clearvalue() {
    bagdetail.text = '';
    airlinenumb.text = '';
    country_sortname = ''.obs;
    last_mile_port = ''.obs;
    logistics_name = ''.obs;
    clearance_type_label = ''.obs;
    is_having_battery_label = ''.obs;
    csb_type_label = ''.obs;
    bag_barcode = ''.obs;
    bag_weight = ''.obs;
  }

  BaglableData(String bagid) async {
    statusCode.value = 0;
    Map<String, dynamic> output1;
    try {
      log2.value = 1;
      isLoading(true);
      var data = {"bag_id": bagid};
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.bagdetails,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          output1 = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output1['status'] == 'success') {
            print('donee');
            print(response.data);
            print('done1');
            userModel.value = BaglabelModule.fromJson(response.data);
            await storage.write('Baglable', userModel.value.toJson());
            bagdetail.text = userModel.value.bagDetails;
            airlinenumb.text = userModel.value.airlineNumber;
            country_sortname.value = userModel.value.countrySortname;
            last_mile_port.value = userModel.value.lastMilePort;
            logistics_name.value = userModel.value.logisticsName;
            clearance_type_label.value = userModel.value.clearanceTypeLabel;
            is_having_battery_label.value =
                userModel.value.isHavingBatteryLabel;
            csb_type_label.value = userModel.value.csbTypeLabel;
            bag_barcode.value = userModel.value.bagBarcode;
            bag_weight.value = userModel.value.bagWeight;
            log2.value = 4;
            print(userModel);

            isLoading(false);
          }
        } else if (response.statusCode == 200 && output1['status'] == 'error') {
          if (output1["html_message"] == "Please Login") {
            Get.offAllNamed(RoutesApp.login);
            // _resetAndOpenPage();
          } else if (output1["html_message"] == "Access Denied") {
            Get.offAllNamed(RoutesApp.login);
          } else {
            storage.erase();

            isLoading(false);
          }
        } else {
          isLoading(false);
          print(response);
        }
      });
    } catch (e) {
      isLoading(false);
      log2.value = 4;
    }
    return output1;
  }

  assignToUser() async {}

  assignData() async {}
}

bool isUserLogin() {
  try {
    if (true) {
      return true;
    }
  } catch (e) {
    return false;
  }
}

// void _resetAndOpenPage() {
//   BuildContext context;
//   GetStorage storage = GetStorage();
//   Get.offAllNamed(RoutesApp.login);
//   ScaffoldMessenger.of(context)
//       .showSnackBar(SnackBar(content: const Text('Please Login')));
//   storage.erase();
// }
