import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:xborders/core/api/config/api_request.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';

import 'package:xborders/module/inwardscan/controller/inward_controller.dart';
import 'package:xborders/module/inwardscan/widget/inwardscan_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:get_storage/get_storage.dart';

class User {
  final String img;
  final String num;
  final String word;
  User(this.img, this.word, this.num);

  User.fromJson(Map<String, dynamic> json)
      : img = json['img'],
        word = json['word'],
        num = json['num'];

  Map<String, dynamic> toJson() => {'img': img, 'word': word, 'num': num};
}

class InwardScan extends StatefulWidget {
  final String totalcount;
  const InwardScan({Key key, this.totalcount}) : super(key: key);

  @override
  State<InwardScan> createState() => _InwardScanState();

  static InwardScan fromJson(data) {}
}

const double width = 60;
const double height = 26;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _InwardScanState extends State<InwardScan> with TickerProviderStateMixin {
  var page_title = Get.arguments[0];
  var scan_type = Get.arguments[1];
  AnimationController animation;
  Animation<double> _fadeInFadeOut;
  String _scanBarcode = 'Unknown';

  String textControllerr = 'Unknown';
  // var invardModel = InvardDetailController().obs;
  InwardDetailController invardDetailController = new InwardDetailController();
  List data = [].obs;
  final textController = TextEditingController();
  double xAlign;
  Color loginColor;
  Color signInColor;
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  clearvalue() {
    textController.text = '';
  }

  Future<void> scanBarcodeNormal(context, Value) async {
    String textcontroller = textController.text.toString();
    if (await ApiRequest.checkIsConnectEstablish()) {
      Utils.showMessage(
          message: 'Please check your internet connection or try again later');
      // statusCode.value = 300;
    } else {
      if (textController.toString() != "-1") {
        totalcountnumber++;
        User us =
            User("assets/icons/loading.png", "In Progress", textcontroller);
        data.add(us);
        setState(() {
          textControllerr = textcontroller;
        });
        print("1");

        var output = await invardDetailController.invardgetData1(
            scan_type.toString(), textcontroller, totalcountnumber - 1);

        print(output);
        if (output[0]['status'] == 'success') {
          print("success");
          User us_1 = User("assets/icons/right_icon.png",
              output[0]['html_message'], data[output[1]].num);
          data[output[1]] = us_1;
        } else if (output[0]['status'] == 'error') {
          print(data[output[1]].num);
          if (output[0]['html_message'] == 'Please Login') {
            _resetAndOpenPage(context);
          } else {
            User us_1 = User("assets/icons/wrong_icon.png",
                output[0]['html_message'], data[output[1]].num);

            data[output[1]] = us_1;
          }
        } else {
          User us_1 = User("assets/icons/wrong_icon.png",
              "Something went wrong", data[output[1]].num);
          data[output[1]] = us_1;
        }
        setState(() {
          totalcountnumber = totalcountnumber;
        });
        clearvalue();
      }
    }
  }

  Future<void> scanBarcodeNormal2(context) async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (barcodeScanRes.toString() != "-1") {
      totalcountnumber++;
      User us = User("assets/icons/loading.png", "In Progress", barcodeScanRes);
      data.add(us);
      setState(() {
        _scanBarcode = barcodeScanRes;
      });
      print("1");
      var output =
          await invardDetailController.invardgetData("1", barcodeScanRes);
      //print(await invardDetailController.invardgetData("1", barcodeScanRes));
      print("output");
      print(output);
      if (output['status'] == 'success') {
        User us_1 = User("assets/icons/right_icon.png", output['html_message'],
            barcodeScanRes);
        data[totalcountnumber.toInt() - 1] = us_1;
      } else if (output['status'] == 'error') {
        if (output['html_message'] == 'Please Login') {
          _resetAndOpenPage(context);
        } else {
          User us_1 = User("assets/icons/wrong_icon.png",
              output['html_message'], barcodeScanRes);
          data[totalcountnumber.toInt() - 1] = us_1;
        }
      } else {
        User us_1 = User("assets/icons/wrong_icon.png", "Something went wrong",
            barcodeScanRes);
        data[totalcountnumber.toInt() - 1] = us_1;
      }
      setState(() {
        totalcountnumber = totalcountnumber;
      });
    }
  }

  int totalcountnumber = 0;

  bool isSwitched = false;
//  var textValue = Variable.winback;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            // Here we create one to set status bar color
            backgroundColor: Colors
                .black, // Set any color of status bar you want; or it defaults to your theme's primary color
          )),
      body: Column(
        children: [
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.black,
                      )),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      page_title.toString(),
                      style: headingInvardStyle,
                    )),
              ),
              Container(
                padding: EdgeInsets.only(right: 6),
                child: _switchValue == true
                    ? Text(
                        'Manually',
                        style: manually,
                      )
                    : Text(
                        'Device',
                        style: manually,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(right: 10),
              //   child: Container(
              //     width: 60,
              //     height: 28,
              //     child: CustomSwitch(
              //       value: isSwitched,
              //       activeColor: Colors.green,
              //       onChanged: (value) {
              //         print("VALUE : $value");
              //         setState(() {
              //           isSwitched = value;
              //         });
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          _switchValue == false
              ? Container(
                  alignment: Alignment.center,
                  // padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      controller: textController,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        print("scanned");
                        scanBarcodeNormal(context, value);
                      },

                      // onChanged: (value) =>
                      //     {scanBarcodeNormal(context, value), clearvalue()},
                      minLines: 1,
                      maxLines: 8,
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide:
                              BorderSide(color: Color(0xffd1d5db), width: 1),
                        ),
                        hintText: Variable.Scanhere,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide:
                              BorderSide(color: Color(0xffd1d5db), width: 1),
                        ),
                        filled: true,
                        fillColor: Color(0xffffffff),
                      )),
                )
              : InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    scanBarcodeNormal2(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 47,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xfff3f4f6)),
                    child: Row(
                      children: [
                        // Container(
                        //     padding: EdgeInsets.only(
                        //       left: 20,
                        //     ),
                        //     child:Text('mm')),
                        Container(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(Variable.scanhere),
                        )
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: 18,
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Color(0xffe5e7eb),
                  ),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(
                      height: 15,
                    ),
                    totalcountnumber != 0
                        ? Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Row(
                              children: [
                                Text(
                                  Variable.totalcount,
                                  style: serachtext,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text(
                                    totalcountnumber.toString(),
                                    style: totalcountnum,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 22,
                    ),
                    Obx(() => Column(
                          children: data
                              .map((e) => InwardCard(
                                    img: e.img.toString(),
                                    word: e.word.toString(),
                                    num: e.num.toString(),
                                  ))
                              .toList()
                              .reversed
                              .toList(),
                        ))
                  ]))))
        ],
      ),
    );
  }
}

void _resetAndOpenPage(context) {
  BuildContext context;
  GetStorage storage = GetStorage();
  //Utils.showMessage(message: "Please Login");
  storage.erase();
  Get.offAllNamed(RoutesApp.login);
}
