import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/reprintscan/controller/reprint_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';

class ReprintScan extends StatefulWidget {
  @override
  State<ReprintScan> createState() => _ReprintScanState();
}

class _ReprintScanState extends State<ReprintScan>
    with TickerProviderStateMixin {
  String _scanBarcode = 'Unknown';
   bool _switchValue = false;
   

  final reprintDetailController reprintscanDetailController =
      new reprintDetailController();
  List data = [].obs;
  final textController = TextEditingController();
  GetStorage storage = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  clearvalue() {
    textController.text = '';
  }

  Future<void> scanBarcodeNormal(context) async {
    String textcontroller = textController.text.toString();

    if (textcontroller.toString() != "-1") {
      totalcountnumber++;

      setState(() {
        _scanBarcode = textcontroller;
      });
      print("1");
      Config.awb = textcontroller;

      var output =
          await reprintscanDetailController.ReprintData(textcontroller);
      clearvalue();

      storage.write('get_scan', output);
      Config.omid = reprintscanDetailController.ReprintModel.value == null
          ? ''
          : reprintscanDetailController.ReprintModel.value.omRowId;
      print(Config.awb);

      print(output);
      if (output['status'] == 'success') {
        print("1t656576t");
        Get.toNamed(RoutesApp.reprintyesscan);
      } else if (output['status'] == 'error') {
        
        Utils.showMessage(message: output['html_message']);
      } else {
        return '';
      }

      setState(() {
        totalcountnumber = totalcountnumber;
      });
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

      setState(() {
        _scanBarcode = barcodeScanRes;
      });
      print("1");
      Config.awb = barcodeScanRes;

      var output =
          await reprintscanDetailController.ReprintData(barcodeScanRes);
      clearvalue();

      storage.write('get_scan', output);
      Config.omid = reprintscanDetailController.ReprintModel.value == null
          ? ''
          : reprintscanDetailController.ReprintModel.value.omRowId;
      print(Config.awb);

      print(output);
      if (output['status'] == 'success') {
        print("1t656576t");
        Get.toNamed(RoutesApp.reprintyesscan);
      } else if (output['status'] == 'error') {
        
        Utils.showMessage(message: output['html_message']);
      } else {
        return '';
      }
      setState(() {
        totalcountnumber = totalcountnumber;
      });
    }
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    Get.offAllNamed(RoutesApp.cclportal);
    return Future.value(true);
  }

  int totalcountnumber = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
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
                       onPressed: () => Get.offAllNamed(RoutesApp.cclportal),
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
                      Variable.ReprintScan,
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
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.only(left: 10),
            //       child: IconButton(
            //           onPressed: () => Get.offAllNamed(RoutesApp.cclportal),
            //           icon: Icon(
            //             Icons.arrow_back,
            //             size: 24,
            //             color: Colors.black,
            //           )),
            //     ),
            //     Container(
            //         padding: EdgeInsets.only(left: 10),
            //         child: Text(
            //           Variable.ReprintScan,
            //           style: headingInvardStyle,
            //         )),
            //   ],
            // ),
            SizedBox(
              height: 13,
            ),
             _switchValue == false
              ?
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                  autofocus: true,
                  controller: textController,
                   textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        print("scanned");
                        scanBarcodeNormal(context);
                      },
                  // onChanged: (value) {
                  //   scanBarcodeNormal(context);
                  //   // clearvalue();
                  // },
                  minLines: 1,
                  maxLines: 8,
                  // controller: controller.bagdetail,

                  // allow user to enter 5 line in textfield
                  keyboardType: TextInputType
                      .number, // user keyboard will have a button to move cursor to next line
                  // controller: _Textcontroller,
                  decoration: InputDecoration(
                    isDense: true,
                    // contentPadding:
                    //     EdgeInsets.only(left: 15, top: 56, bottom: 56),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      borderSide:
                          BorderSide(color: Color(0xffd1d5db), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      borderSide:
                          BorderSide(color: Color(0xffd1d5db), width: 1),
                    ),
                    hintText: Variable.Scanhere,
                    filled: true,
                    fillColor: Color(0xffffffff),
                  )),
            ): InkWell(
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
          ],
        ),
      ),
    );
  }
}

// void _resetAndOpenPage(context) {
//   BuildContext context;
//   GetStorage storage = GetStorage();
//   Get.snackbar(
//     '',
//     'Please Login',
//     snackPosition: SnackPosition.BOTTOM,
//     backgroundColor: Color(0xff0f1210),
//     colorText: Color(0xffffffff),
//     padding: EdgeInsets.symmetric(
//       vertical: 2,
//     ),
//   );
//   storage.erase();
//   Get.offAllNamed(RoutesApp.login);
// }
