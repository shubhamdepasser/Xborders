import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/hwabscan/model/hwabscan_model.dart';
import 'package:xborders/module/hwabscan/views/hwad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HwabDetailController extends GetxController {
  Map<String, dynamic> output;
  var BagDetailModel = HwabModule().obs;
  var isLoading_1 = true.obs;
  GetStorage storage = GetStorage();
  String Hwab = 'Hwab';
  var statusCode = 0.obs;
  HwabPage hwabPage = new HwabPage();
  var omrowid = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  clearvalue() {
    omrowid = ''.obs;
  }

  HwabData(String lastmile) async {
    print(lastmile);
    statusCode.value = 0;

    try {
      print('printedddddddd');
      isLoading(true);
      var data = {"last_mile_awb": lastmile};
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Configg.createbag,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        print(response);
        if (response != null) {
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            print('response done');
            if (BagDetailModel.value.isBagExceeded == 1) {
              BagDetailModel.value = HwabModule.fromJson({
                "status": 'success',
                "isShowModal": 1,
                "allBmDataArray": [],
                "tempBagId": '',
                "bagId": response.data.bag_id,
                "bagWeight": response.data.bag_weight,
                "finalPhyWeight": "",
                "omRowId": "",
                "isNewBag": 0,
                "isBagExceeded": response.data.is_bag_exceeded
              });
            } else {
              BagDetailModel.value = HwabModule.fromJson(response.data);
              await storage.write('Hwab', BagDetailModel.value.toJson());
              omrowid.value = BagDetailModel.value.omRowId;
            }

            isLoading(false);
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Please Login") {
              Get.offAllNamed(RoutesApp.login);
              //_resetAndOpenPage();
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
      print(e);
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

// void _resetAndOpenPage() {
//   BuildContext context;
//   GetStorage storage = GetStorage();
//   Get.offAllNamed(RoutesApp.login);
//   ScaffoldMessenger.of(context)
//       .showSnackBar(SnackBar(content: const Text('Please Login')));
//   storage.erase();
// }
