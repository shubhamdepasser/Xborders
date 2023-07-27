import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/hwabscan/model/load_model.dart';
import 'package:xborders/module/hwabscan/views/hwad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoadDetailController extends GetxController {
  var LoadDetailModel = LoadModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String Baglable = 'Baglable';
  var statusCode = 0.obs;
  HwabPage hwabPage = new HwabPage();

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  LoadData(String scan, String omrowiddata) async {
    Map<String, dynamic> output;

    statusCode.value = 0;

    try {
      isLoading(true);
      var data = {"bag_barcode": scan, "om_row_id": omrowiddata};
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.load,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            LoadDetailModel.value = LoadModule.fromJson(response.data);
            await storage.write('Baglable', LoadDetailModel.value.toJson());

            //isLoading(false);
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Access Denied") {
              _resetAndOpenPage();
            } else if (output["html_message"] == "Access Denied") {
              Get.offAllNamed(RoutesApp.login);
            } else {
              storage.erase();

              isLoading(false);
            }
          } else {
            isLoading(false);
            print(response);
          }
        }
      });
    } catch (e) {
      isLoading(false);
    }
    return output;
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

void _resetAndOpenPage() {
  BuildContext context;
  GetStorage storage = GetStorage();
  Get.offAllNamed(RoutesApp.login);
  Utils.showMessage(message: 'Please Login');

  storage.erase();
}
