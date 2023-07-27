import 'dart:io';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:image_picker/image_picker.dart';

class Utils {
  static void displayErrorPrint({String message}) => debugPrint(message);

  static showMessage({String title, String message, Color color}) async {
    Get.snackbar(title ?? null, message ?? null,
        isDismissible: true,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: color == null ? Color(0xFF172B4D) : color,
        backgroundGradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff172B4D), Color(0xff18163C)]),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 23, right: 23),
        titleText: title != null
            ? Text(title,
                style: normalRubikSize(fontSize: 16, color: Color(0xffffffff)))
            : Container(),
        messageText: message != null
            ? Text(message,
                style: normalRubikSize(fontSize: 13, color: Color(0xffB3BAC5)))
            : Container(),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeOut,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 16);
    await Future.delayed(Duration(seconds: 3));
  }

  static showMessageTop({String title, String message, Color color}) async {
    Get.snackbar(title ?? null, message ?? null,
        isDismissible: true,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor:
            color == null ? Color.fromRGBO(253, 120, 71, 1) : color,
        backgroundGradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(253, 120, 71, 1),
              Color.fromRGBO(253, 120, 71, 1)
            ]),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 23, right: 23),
        titleText: title != null
            ? Text(title,
                style: normalRubikSize(fontSize: 16, color: Color(0xffffffff)))
            : Container(),
        messageText: message != null
            ? Text(message,
                style: normalRubikSize(fontSize: 13, color: Colors.black))
            : Container(),
        forwardAnimationCurve: Curves.easeOut,
        reverseAnimationCurve: Curves.easeOut,
        snackPosition: SnackPosition.TOP,
        borderRadius: 16);
    await Future.delayed(Duration(seconds: 10));
  }

  static Future selectImage(Rx<File> image) async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(pickedFile);
    if (pickedFile.path != null) {
      image.value = File(pickedFile.path);
      final bytes = image.value.readAsBytesSync().lengthInBytes;
      print(bytes);
      final kb = bytes / 1024;
      if (kb < 2000) {
        print("t");
        return true;
      } else {
        print("f");
        showMessage(message: 'Your image size should be below then 2mb');
        image.value = File('');
        return false;
      }
    } else {
      image.value = File('');
      return false;
    }
  }
}
