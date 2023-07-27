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
  final String word1;
  final String word2;

  const InwardScan({Key key, this.word1, this.word2}) : super(key: key);

  @override
  State<InwardScan> createState() => _InwardScanState(word1, word2);
}

class _InwardScanState extends State<InwardScan> with TickerProviderStateMixin {
  final String para1;
  final String para2;
  AnimationController animation;
  Animation<double> _fadeInFadeOut;

  String _scanBarcode = 'Unknown';
  // var invardModel = InvardDetailController().obs;
  InwardDetailController invardDetailController = new InwardDetailController();
  List data = [].obs;

  _InwardScanState(this.para1, this.para2);

  @override
  void initState() {
    super.initState();
    // animation = AnimationController(
    //   vsync: this,
    //   duration: Duration(seconds: 3),
    // );
    // _fadeInFadeOut = Tween<double>(begin: 0.1, end: 1).animate(animation);

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animation.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animation.forward();
    //   }
    // });
    // animation.forward();
  }

  Future<void> scanBarcodeNormal(context) async {
    String barcodeScanRes;

    try {
      // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      //     '#ff6666', 'Cancel', true, ScanMode.BARCODE);
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
      //   data[totalcountnumber-1] = us_1;
      // else if error api 200
      // else 400 some

    }
  }

  int totalcountnumber = 0;
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
              Container(
                padding: EdgeInsets.only(left: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.black,
                    )),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    para1,
                    style: headingInvardStyle,
                  )),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          InkWell(
            onTap: () {
              scanBarcodeNormal(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xfff3f4f6)),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Image.asset(
                        'assets/icons/qr.png',
                        height: 30,
                        width: 30,
                      )),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
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

  Utils.showMessage(message: 'Please Login');
  storage.erase();
  Get.toNamed(RoutesApp.login);
}
