import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/hwabscan/model/pdf_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PdfController extends GetxController {
  var PdfModel = PdfModule().obs;
  var isLoading_1 = false.obs;
  GetStorage storage = GetStorage();
  String Baglable = 'Baglable';
  var statusCode = 0.obs;
  var showpdf = ''.obs;
  Map<String, dynamic> output;
  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  PdfData(String bagid) async {
    print('object');
    statusCode.value = 0;

    try {
      //isLoading(true);
      var data = {"bag_id": bagid};
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.pdf,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading_1)
          .then((response) async {
        if (response != null) {
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            PdfModel.value = PdfModule.fromJson(response.data);
            await storage.write('Baglable', PdfModel.value.toJson());
            showpdf.value = PdfModel.value.bagLabelS3Url;
            print(PdfModule);
            //isLoading(false);
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Access Denied") {
              _resetAndOpenPage();
            } else {
              storage.erase();

              //isLoading(false);
            }
          } else {
            //isLoading(false);
            print(response);
          }
        }
      });
    } catch (e) {
      //isLoading(false);
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
