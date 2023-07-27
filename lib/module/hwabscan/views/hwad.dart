import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/hwabscan/controller/hwabscan_controller.dart';
import 'package:xborders/module/hwabscan/views/BottomSheetDesign.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:sliding_sheet/sliding_sheet.dart';

class HwabPage extends StatefulWidget {
  const HwabPage({
    Key key,
  }) : super(key: key);

  @override
  State<HwabPage> createState() => _HwabPageState();
}

class _HwabPageState extends State<HwabPage> {
  String _scanBarcode = 'Unknown';
  //var invardModel =HwabDetailController().obs;
  HwabDetailController hwabDetailController = Get.put(HwabDetailController());
  final textController = TextEditingController();
  GetStorage storage = GetStorage();
  bool shouldPop = true;
   bool _switchValue = false;
  @override
  void initState() {
    super.initState();
  }

  clearvalue() {
    textController.text = '';
  }

  Future<void> scanBarcodeNormal(context) async {
    // String barcodeScanRes;
    String textcontroller = textController.text.toString();

    if (textcontroller.toString() != "-1") {
      setState(() {
        _scanBarcode = textcontroller;
      });
      print("1");
      Configg.lastmile = textcontroller;

      var output = await hwabDetailController.HwabData(textcontroller);
      clearvalue();
      print('output');
      print(output);
      print(Configg.lastmile);

      print('ggggg');

      print("output");
      if (output['isBagExceeded'] == 1) {
        Get.dialog(
          AlertDialog(
            //title: const Text('Dialog'),
            content: Text("Bag weight exceeded current weight: " +
                output["bag_weight"].toString() +
                " KG"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Get.back(),
              ),
              TextButton(
                child: const Text("Close Bag"),
                onPressed: () => Get.toNamed(RoutesApp.Baglable),
              ),
            ],
          ),
        );
      } else {
        if (output['status'] == 'error') {
          return Utils.showMessage(message: output['html_message']);
        } else if (output['status'] == 'success') {
          if (output['bag_id'].toString() == '0'.toString()) {
            print('print scanner herereeeeeeeeeeeeeeeee');
            // Get.bottomSheet(RoutesApp.bottomsheetpage)
            storage.write('create_hwab', output);
            showSlidingBottomSheet(context,
                builder: (context) => SlidingSheetDialog(
                    isDismissable: false,
                    cornerRadius: 16,
                    snapSpec: SnapSpec(
                      snappings: [1, 1],
                    ),
                    builder: buildSheet));
          } else {
            print("bag lable");
            Get.toNamed(RoutesApp.Baglable);
          }
        }
      }
    } else {
      return '';
    }
    setState(() {});
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
      setState(() {
        _scanBarcode = barcodeScanRes;
      });
      print("1");
      Configg.lastmile = barcodeScanRes;

      var output = await hwabDetailController.HwabData(barcodeScanRes);
      clearvalue();
      print('output');
      print(output);
      print(Configg.lastmile);

      print('ggggg');

      print("output");
      if (output['isBagExceeded'] == 1) {
        Get.dialog(
          AlertDialog(
            //title: const Text('Dialog'),
            content: Text("Bag weight exceeded current weight: " +
                output["bag_weight"].toString() +
                " KG"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Get.back(),
              ),
              TextButton(
                child: const Text("Close Bag"),
                onPressed: () => Get.toNamed(RoutesApp.Baglable),
              ),
            ],
          ),
        );
      } else {
        if (output['status'] == 'error') {
          return Utils.showMessage(message: output['html_message']);
        } else if (output['status'] == 'success') {
          if (output['bag_id'].toString() == '0'.toString()) {
            print('print scanner herereeeeeeeeeeeeeeeee');
            // Get.bottomSheet(RoutesApp.bottomsheetpage)
            storage.write('create_hwab', output);
            showSlidingBottomSheet(context,
                builder: (context) => SlidingSheetDialog(
                    isDismissable: false,
                    cornerRadius: 16,
                    snapSpec: SnapSpec(
                      snappings: [1, 1],
                    ),
                    builder: buildSheet));
          } else {
            print("bag lable");
            Get.toNamed(RoutesApp.Baglable);
          }
        }
      }
    } else {
      return '';
    }
    setState(() {});
  }

  


  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    Get.offAllNamed(RoutesApp.cclportal);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPopCallback(),
      //  {
      //   return Get.offAllNamed(RoutesApp.cclportal);
      // },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.black,
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
                        Get.offAllNamed(RoutesApp.cclportal);
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
                      Variable.hwab,
                  style: PoppinsHeadingHwab,
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
            ],
          ),
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.only(left: 10),
            //       child: IconButton(
            //           onPressed: () {
            //             // Get.back();
            //             Get.offAllNamed(RoutesApp.cclportal);
            //           },
            //           icon: Icon(
            //             Icons.arrow_back,
            //             size: 24,
            //             color: Colors.black,
            //           )),
            //     ),
            //     Container(
            //         child: Text(
            //       Variable.hwab,
            //       style: PoppinsHeadingHwab,
            //     )),
            //   ],
            // ),
            SizedBox(
              height: 18,
            ),
            Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.topLeft,
                child: Text(
                  Variable.Enterhawb,
                  style: HWAB,
                )),
            SizedBox(height: 10),

              _switchValue == false
              ? 
              
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: textController,
                   textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        print("scanned");
                        scanBarcodeNormal(context);
                      },
                  // onChanged: (value) {
                  //   scanBarcodeNormal(context);
                  //   //Get.put(HwabDetailController()).HwabData(_scanBarcode);
                  //   // clearvalue();
                  // },
                  minLines: 1,
                  maxLines: 8,
                  // controller: controller.bagdetail,

                  // allow user to enter 5 line in textfield
                  // keyboardType: TextInputType
                  // .multiline, // user keyboard will have a button to move cursor to next line
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
                    hintText: Variable.scanhere,
                    filled: true,
                    fillColor: Color(0xffffffff),
                  )),
            ):InkWell(
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
            // InkWell(
            //   onTap: () {
            //     scanBarcodeNormal(context);
            //     Get.put(HwabDetailController()).HwabData(_scanBarcode);

            //     // scanBarcodeNormal;
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.86,
            //     padding: EdgeInsets.only(top: 10, bottom: 10),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Color(0xffd1d5db), width: 1),
            //         borderRadius: BorderRadius.circular(6),
            //         color: Color(0xffffffff)),
            //     child: Row(
            //       children: [
            //         Container(
            //             padding: EdgeInsets.only(
            //               left: 20,
            //             ),
            //             child: Image.asset(
            //               'assets/icons/qr.png',
            //               height: 30,
            //               width: 30,
            //             ))
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSheet(context, State) => Material(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Bottomsheetdesign()
        ],
      ),
    );
