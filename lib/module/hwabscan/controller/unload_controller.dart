import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/hwabscan/model/unload_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UnloadController extends GetxController {
  var UnloadDetailModel = UnloadModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String Baglable = 'Baglable';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  unloadData(String rowid) async {
    statusCode.value = 0;
    Map<String, dynamic> unloadoutput;
    try {
      isLoading(true);
      var data = {
        "row_id": rowid,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.unload,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          Map<String, dynamic> output =
              unloadoutput = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            UnloadDetailModel.value = UnloadModule.fromJson(response.data);
            await storage.write('Baglable', UnloadDetailModel.value.toJson());

            print(UnloadDetailModel);

            print(output);

            isLoading(false);
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Access Denied") {
              _resetAndOpenPage();
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
    return unloadoutput;
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
