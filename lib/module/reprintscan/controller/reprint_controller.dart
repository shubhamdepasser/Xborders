import 'dart:io';

import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/module/reprintscan/model/reprint_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class reprintDetailController extends GetxController {
  var ReprintModel = ReprintscanModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  final imageFile = File('').obs;
  final imageFile1 = File('').obs;
  final imageFile2 = File('').obs;
  String createbag = 'createbag';
  var statusCode = 0.obs;
  TextEditingController reprintremark = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
  }

  clearvalue() {
    reprintremark.text = '';
    reprintremark.text = '';
  }

  ReprintData(String firstmileawb) async {
    statusCode.value = 0;
    Map<String, dynamic> output;

    try {
      isLoading(true);
      var data = {
        'first_mile_awb': firstmileawb,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.Reprintscan,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            ReprintModel.value = ReprintscanModule.fromJson(response.data);
            await storage.write('Reprintscan', ReprintModel.value.toJson());
            reprintremark.text = ReprintModel.value.reprintRemark;

            print(ReprintModel);

            isLoading(false);
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Please Login") {
              Get.offAllNamed(RoutesApp.login);
              // _resetAndOpenPage();
            } else if (output["html_message"] == "Access Denied") {
              Get.offAllNamed(RoutesApp.login);
            } else {
              isLoading(false);
              print(response);
            }
          }
        }
      });
    } catch (e) {
      isLoading(false);
    }
    return output;
  }
}
