import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/inwardscan/model/inward_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InwardDetailController extends GetxController {
  var inwardmodel = InwardScan().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String user = 'user';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  invardgetData1(String scantype, String scaninput, int index) async {
    print('object');
    statusCode.value = 0;
    Map<String, dynamic> output;
    try {
      isLoading(true);
      var data = {
        'scan_type': scantype,
        'scan_input_id': scaninput,
      };
      print(data);
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.invardscan,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            // print(response.data);
            inwardmodel.value = InwardScan.fromJson(response.data);
            await storage.write('user', inwardmodel.value.toJson());
            print(inwardmodel);

            isLoading(false);
            print(output);
            return output['status'].toString();
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Access Denied") {
              Get.offAllNamed(RoutesApp.login);
              Utils.showMessage(message: 'Please Login');
              // Get.snackbar(
              //   '',
              //   'Please Login',
              //   snackPosition: SnackPosition.BOTTOM,
              //   backgroundColor: Color(0xff0f1210),
              //   colorText: Color(0xffffffff),
              //   padding: EdgeInsets.symmetric(
              //     vertical: 2,
              //   ),
              // );
            }

            inwardmodel.value = InwardScan.fromJson(response.data);
            await storage.write('user', inwardmodel.value.toJson());

            isLoading(false);
            print(output);
            return output['status'].toString();
          } else {
            storage.erase();

            isLoading(false);
            print("3");
            return output;
          }
        } else {
          isLoading(false);
          print(response);
          print("3");
          return "";
        }
      });
    } catch (e) {
      isLoading(false);
      print("e");
      return "";
    }
    var result = [output, index];
    return result;
  }

  invardgetData(String scantype, String scaninput) async {
    print('object');
    statusCode.value = 0;
    Map<String, dynamic> output;
    try {
      isLoading(true);
      var data = {
        'scan_type': scantype,
        'scan_input_id': scaninput,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.invardscan,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            // print(response.data);
            inwardmodel.value = InwardScan.fromJson(response.data);
            await storage.write('user', inwardmodel.value.toJson());
            print(inwardmodel);

            isLoading(false);
            print(output);
            return output['status'].toString();
          } else if (response.statusCode == 200 &&
              output['status'] == 'error') {
            if (output["html_message"] == "Access Denied") {
              Get.offAllNamed(RoutesApp.login);
              Get.snackbar(
                '',
                'Please Login',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xff0f1210),
                colorText: Color(0xffffffff),
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                ),
              );
            }

            inwardmodel.value = InwardScan.fromJson(response.data);
            await storage.write('user', inwardmodel.value.toJson());

            isLoading(false);
            print(output);
            return output['status'].toString();
          } else {
            storage.erase();

            isLoading(false);
            print("3");
            return output;
          }
        } else {
          isLoading(false);
          print(response);
          print("3");
          return "";
        }
      });
    } catch (e) {
      isLoading(false);
      print("e");
      return "";
    }
    return output;
  }
}
