import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/module/hwabscan/model/submit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SubmitController extends GetxController {
  var SubmitDetailModel = SubmitModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String Baglable = 'Baglable';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  SubmitData(String bagid, String airlineno, String bagdetails,
      String parcelcount, String bagclosed) async {
    statusCode.value = 0;
    Map<String, dynamic> output;
    try {
      isLoading(true);
      var data = {
        "bag_id": bagid,
        "airline_number": airlineno,
        "bag_details": bagdetails,
        "total_parcel_count": parcelcount,
        "is_closed_bag": bagclosed,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.submit,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = await new Map<String, dynamic>.from(response.data);

          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            SubmitDetailModel.value = SubmitModule.fromJson(response.data);
            await storage.write('Baglable', SubmitDetailModel.value.toJson());

            print(SubmitDetailModel);
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
      print("error");
      isLoading(false);
    }
    print(output);
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
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
    'Please Login',
  )));
  storage.erase();
}
