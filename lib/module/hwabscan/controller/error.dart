// // ignore: file_names

// import 'package:xborders/core/api/config/api_request.dart';
// import 'package:xborders/core/api/config/config.dart';
// import 'package:xborders/module/hwabscan/model/hwabscan_model.dart';
// // import 'package:xborders/module/invardscan/model/invard_model.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class UnloadController extends GetxController {
//   var BagDetailModel = HwabModule().obs;
//   var isLoading = false.obs;
//   GetStorage storage = GetStorage();
//   String Baglable = 'Baglable';
//   var statusCode = 0.obs;

//   @override
//   void onInit() async {
//     //if (Get.isLogEnable) Get.isLogEnable = AppConstant.debug;
//     super.onInit();
//     await assignToUser();
//   }

//   unloadData(String rowid) async {
//     // print(lastmile);
//     statusCode.value = 0;

//     try {
//       isLoading(true);
//       var data = {
//         "row_id": '40',
//       };
//       await ApiRequest.sendRequest(
//               bodyData: data,
//               requestUrlData: Config.submit,
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
//             BagDetailModel.value = HwabModule.fromJson(response.data);
//             await storage.write('Baglable', BagDetailModel.value.toJson());

//             print(BagDetailModel);
//             // if (output['temp_bag_id'] == '0') {
//             //   Get.toNamed(RoutesApp.Baglable);
//             // } else {
//             //   Get.toNamed(RoutesApp.Baglable);
//             // }
//             print(output);
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
//     return '';
//   }

//   // String navigatingRoute() {
//   //   return isUserLogin() ? RoutesApp.cclportal : RoutesApp.login;
//   // }

//   assignToUser() async {
//     // try {
//     //   if (isUserLogin()) {
//     //     userModel.value = UserModel.fromJson(await storage.read('user'));
//     //     assignData();
//     //   }
//     // } catch (e) {
//     //   //Utils.displayErrorPrint(message: e.toString() + ' assignToUser');
//     // }
//   }

//   assignData() async {
//     // try {
//     //   // Config.userId = userModel.value.user[0].userId.toString();
//     //   // Config.mobileToken = userModel.value.user[0].mobileAccessToken;
//     //   await Future.delayed(Duration(seconds: 2)).then((value) {
//     //     Get.put(LoginController(), permanent: true);
//     //   });
//     // } catch (e) {
//     //   //Utils.displayErrorPrint(message: e.toString() + ' assignData');
//     // }
//   }
// }

// bool isUserLogin() {
//   try {
//     if (true) {
//       return true;
//     }
//   } catch (e) {
//     // Utils.displayErrorPrint(message: e.toString() + ' isUserLogin');
//     return false;
//   }
// }
