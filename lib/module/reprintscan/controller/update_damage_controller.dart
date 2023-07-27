import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/base_64_custom.dart';

import 'package:xborders/module/reprintscan/model/update_damage_model.dart';
import 'package:xborders/module/reprintscan/model/uploadimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ReprintdamageController extends GetxController {
  var ReprintdamageModel = Updatedamagemodel().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'createbag';
  var statusCode = 0.obs;
  TextEditingController reprint = TextEditingController();
  UploadimageController uploadcontroller = UploadimageController();

  @override
  void onInit() async {
    super.onInit();
    await assignToUser();
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  ReprintdamageData(
      String isdamage,
      String firstmileawb,
      String isprintlabel,
      String reprintremark,
      String ccsecurity,
      firstfile,
      secondfile,
      thirdfile) async {
    statusCode.value = 0;

    String file1base64;
    String file2base64;
    String file3base64;
    var res_file1_name = '';
    var res_file2_name = '';
    var res_file3_name = '';
    statusCode.value = 0;

    if (firstfile != '') {
      print('1');

      file1base64 = Base64Custom.convertImageBase64(firstfile);
      res_file1_name = await uploadcontroller.uploadimageData('2', file1base64);
      print(res_file1_name);
    }
    if (secondfile != "") {
      print('2');

      file2base64 = Base64Custom.convertImageBase64(secondfile);
      res_file2_name = await uploadcontroller.uploadimageData('2', file2base64);
      print(res_file2_name);
    }

    if (thirdfile != "") {
      file3base64 = Base64Custom.convertImageBase64(thirdfile);
      res_file3_name = await uploadcontroller.uploadimageData('2', file3base64);
      print(res_file3_name);
    }
    print(reprintremark);
    Map<String, dynamic> output;
    try {
      isLoading(true);
      var data = {
        "is_damage": isdamage,
        'first_mile_awb': firstmileawb,
        "is_print_label": isprintlabel,
        "reprint_remark": reprintremark,
        "cc_security_check": ccsecurity,
        "file_name1": res_file1_name,
        "file_name2": res_file2_name,
        "file_name3": res_file3_name
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.Reprintscandamage,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            ReprintdamageModel.value =
                Updatedamagemodel.fromJson(response.data);
            await storage.write(
                'Reprintscan', ReprintdamageModel.value.toJson());

            print(ReprintdamageModel);

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
    return output;
  }

  assignToUser() async {}

  assignData() async {}
}

class UploadimageController extends GetxController {
  var UploadimageModel = Uploadimage().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'Uploadimage';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  uploadimageData(String scantype, String uploadedimage) async {
    try {
      isLoading(true);
      var data = {
        'scan_type': scantype,
        'uploaded_image': uploadedimage,
        'request_source': 'app',
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.uploadimage,
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
            UploadimageModel.value = Uploadimage.fromJson(response.data);

            print(Uploadimage);

            isLoading(false);
          } else {
            storage.erase();

            isLoading(false);
            return "";
          }
        } else {
          isLoading(false);
          print(response);
          return "";
        }
      });
    } catch (e) {
      isLoading(false);
    }
    return UploadimageModel.value.fileName.toString();
  }
}
