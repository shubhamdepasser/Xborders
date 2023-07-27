import 'dart:io';

import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/module/reprintscan/model/GetWDdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetWDDetailController extends GetxController {
  var GetWDModel = GetWDdetailsModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'Reprint';
  final imageFile = File('').obs;
  final imageFile1 = File('').obs;
  final imageFile2 = File('').obs;
  var statusCode = 0.obs;
  TextEditingController reserveweight = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  clearvalue() {
    reserveweight.text = '';
  }

  GetWDData(String omrowid) async {
    statusCode.value = 0;

    try {
      isLoading(true);
      var data = {
        'om_row_id': omrowid,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.GetWddetails,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          Map<String, dynamic> output =
              new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            GetWDModel.value = GetWDdetailsModule.fromJson(response.data);
            await storage.write('Reprintscan', GetWDModel.value.toJson());
            reserveweight.text = GetWDModel.value.revisedWeight;

            print(GetWDModel);
            isLoading(false);
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
    }
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
