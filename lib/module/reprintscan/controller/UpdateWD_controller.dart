import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/base_64_custom.dart';
import 'package:xborders/module/reprintscan/model/UpdateWD.dart';
import 'package:xborders/module/reprintscan/model/uploadimage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateWDController extends GetxController {
  var updatewdModel = UpdateWdModule().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'UpdateWd';
  var statusCode = 0.obs;

  UploadimageController controller = UploadimageController();

  @override
  void onInit() async {
    super.onInit();
  }

  UpdateWdData(String actualweight, String revisedweight, String omrowid,
      filename1, filename2, filename3) async {
    String file1base64 = '';
    String file2base64 = '';
    String file3base64 = '';
    var res_file1_name = '';
    var res_file2_name = '';
    var res_file3_name = '';
    statusCode.value = 0;
    print(revisedweight);
    if (filename1 != "") {
      file1base64 = Base64Custom.convertImageBase64(filename1);
      print('filename11111111111111111');
      print(filename1);
      res_file1_name = await controller.uploadimageData('1', file1base64);
      print('object');
      print(res_file1_name);
    }
    if (filename2 != "") {
      file2base64 = Base64Custom.convertImageBase64(filename2);
      res_file2_name = await controller.uploadimageData('1', file2base64);
      print('sanket');
    }

    if (filename3 != "") {
      file3base64 = Base64Custom.convertImageBase64(filename3);
      res_file3_name = await controller.uploadimageData('1', file3base64);
      print('2');
    }
    Map<String, dynamic> output;
    try {
      print(actualweight);
      print(revisedweight);
      print(omrowid);
      print(res_file1_name);
      print(res_file2_name);
      isLoading(true);
      var data = {
        'actual_weight': actualweight,
        'revised_weight': revisedweight,
        'om_row_id': omrowid,
        'file_name1': res_file1_name,
        'file_name2': res_file2_name,
        'file_name3': res_file3_name,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.updateWD,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          print(response);
          output = new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            updatewdModel.value = UpdateWdModule.fromJson(response.data);
            await storage.write('Reprintscan', updatewdModel.value.toJson());

            print(updatewdModel);

            isLoading(false);
          } else {
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

class UploadimageController extends GetxController {
  var UploadimageModel = Uploadimage().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String createbag = 'Uploadimage';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    //if (Get.isLogEnable) Get.isLogEnable = AppConstant.debug;
    super.onInit();
  }

  uploadimageData(String scantype, uploadedimage) async {
    // print('object');

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
          if (response.statusCode == 200 &&
              // output['status_code'] == 200 &&
              output['status'] == 'success') {
            print(response.data);
            UploadimageModel.value = Uploadimage.fromJson(response.data);
            //await storage.write('Reprintscan', Uploadimage.value.toJson());

            print(Uploadimage);
            // if (userModel.value.user != null) {
            //   Get.offAllNamed(RoutesApp.cclportal);
            //   print("object");
            //   assignData();
            //   Get.toNamed(RoutesApp.cclportal);
            //   assignData();
            // }
            isLoading(false);
          } else {
            //storage.remove(AppConstant.user);
            storage.erase();
            // await Utils.showMessage(message: response.data['message']);
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
      // Utils.showMessage(message: e.toString() + ' login');
    }
    return UploadimageModel.value.fileName.toString();
  }
}

// class Uploadimage  extends GetxController{
//    var uploadimageModel = Uploadimage().obs;
//   var isLoading = false.obs;
//   GetStorage storage = GetStorage();
//   String createbag = 'UpdateWd';
//   var statusCode = 0.obs;



//     try {
//       isLoading(true);
//       var data = {
//         'actual_weight': actualweight,
//          'revised_weight': revisedweight,
//           'om_row_id': omrowid,
//            'file_name1': res_file1_name,
//             'file_name2': res_file2_name,
//             'file_name3': res_file3_name,

       
//       };
//       await ApiRequest.sendRequest(
//               bodyData: data,
//               requestUrlData: Config.updateWD,
//               isPostRequest: true,
//               statusCode: statusCode,
//               isFetching: isLoading)
//           .then((response) async {
//         if (response != null) {
//           print(response);
//           Map<String, dynamic> output =
//               new Map<String, dynamic>.from(response.data);
//           if (response.statusCode == 200 &&
//               // output['status_code'] == 200 &&
//               output['status'] == 'success') {
//             print(response.data);
//             updatewdModel.value = UpdateWdModule.fromJson(response.data);
//             await storage.write('Reprintscan', updatewdModel.value.toJson());

//             print(updatewdModel);
//             // if (userModel.value.user != null) {
//             //   Get.offAllNamed(RoutesApp.cclportal);
//             //   print("object");
//             //   assignData();
//             //   Get.toNamed(RoutesApp.cclportal);
//             //   assignData();
//             // }
//             isLoading(false);
//           } else {
//             //storage.remove(AppConstant.user);
//             storage.erase();
//             // await Utils.showMessage(message: response.data['message']);
//             isLoading(false);
//           }
//         } else {
//           isLoading(false);
//           print(response);
//         }
//       });
//     } catch (e) {
//       isLoading(false);
//       // Utils.showMessage(message: e.toString() + ' login');
//     }


// }