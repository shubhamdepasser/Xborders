// ignore: file_names
import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/module/auth_user/model/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var userModel = User().obs;
  var isLoading = false.obs;
  GetStorage storage = GetStorage();
  String user = 'user';
  var statusCode = 0.obs;

  @override
  void onInit() async {
    //if (Get.isLogEnable) Get.isLogEnable = AppConstant.debug;
    super.onInit();
    await assignToUser();
  }

  loginUser(String email, String password) async {
    statusCode.value = 0;
    try {
      isLoading(true);
      var data = {
        'email': email,
        'password': password,
      };
      await ApiRequest.sendRequest(
              bodyData: data,
              requestUrlData: Config.loginUrl,
              isPostRequest: true,
              statusCode: statusCode,
              isFetching: isLoading)
          .then((response) async {
        if (response != null) {
          //print(response);
          Map<String, dynamic> output =
              new Map<String, dynamic>.from(response.data);
          if (response.statusCode == 200 && output['status'] == 'error') {
            if (output["html_message"] ==
                "Email id & password does not match.") {
              //_resetAndOpenPage(context);
              Utils.showMessage(message: "Email id & password does not match.");
              print("true");
            }
          }
          if (response.statusCode == 200 && output['status'] == 'success') {
            print(response.data);
            userModel.value = User.fromJson(response.data);
            await storage.write('user', userModel.value.toJson());
            //Config.requestToken = output['request_token'];
            print(userModel);
            if (userModel.value.requestToken != null) {
              // print("object");
              Get.offAllNamed(RoutesApp.cclportal);
              assignData();
              //assignData();
            }
            isLoading(false);
          } else {
            //storage.remove(AppConstant.user);
            Utils.showMessage(message: output["html_message"]);
            storage.erase();
            //await Utils.showMessage(message: response.data['message']);
            isLoading(false);
          }
        } else {
          isLoading(false);
          print(response);
        }
      });
    } catch (e) {
      isLoading(false);
      //Utils.showMessage(message: e.toString() + ' login');
    }
  }

  assignToUser() async {
    try {
      if (isUserLogin()) {
        userModel.value = User.fromJson(await storage.read('user'));
        assignData();
      }
    } catch (e) {
      //Utils.displayErrorPrint(message: e.toString() + ' assignToUser');
    }
  }

  assignData() async {
    try {
      Config.requestToken = userModel.value.requestToken;
      Config.userId = userModel.value.userId;
      await Future.delayed(Duration(seconds: 2)).then((value) {
        Get.put(LoginController(), permanent: true);
      });
    } catch (e) {
      //Utils.displayErrorPrint(message: e.toString() + ' assignData');
    }
  }

  navigatingRoute() {
    return isUserLogin() ? RoutesApp.cclportal : RoutesApp.login;
  }

  bool isUserLogin() {
    try {
      if (storage.hasData('user')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.displayErrorPrint(message: e.toString() + ' isUserLogin');
      return false;
    }
  }
}

void _resetAndOpenPage(context) {
  //BuildContext context;
  //GetStorage storage = GetStorage();
  // Get.toNamed(RoutesApp.login);
  Utils.showMessage(message: 'Please Login');
  //storage.erase();
}
