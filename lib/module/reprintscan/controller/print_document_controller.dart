import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/module/hwabscan/model/pdf_model.dart';
import 'package:xborders/module/reprintscan/model/print_document_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class printdocument extends GetxController {
  var printmodel = Printdocumentmodel().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'createbag';
  var statusCode = 0.obs;
  TextEditingController reprintremark = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
  }

  printData(String document, int userid) async {
    statusCode.value = 0;
    Map<String, dynamic> output;

    try {
      isLoading(true);
      var data = {
        "document_type": document,
        "user_id": userid,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.printdocument,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = await new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            printmodel.value = Printdocumentmodel.fromJson(response.data);
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
    return output;
  }
}
