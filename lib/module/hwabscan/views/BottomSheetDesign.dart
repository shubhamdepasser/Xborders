import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/core/utilities/widget_utilities/loadingscreen.dart';
import 'package:xborders/module/hwabscan/controller/baglable_controller.dart';
import 'package:xborders/module/hwabscan/controller/hwabscan_controller.dart';
import 'package:xborders/module/hwabscan/controller/load_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

class Bottomsheetdesign extends StatefulWidget {
  @override
  State<Bottomsheetdesign> createState() => _BottomsheetdesignState();
}

class _BottomsheetdesignState extends State<Bottomsheetdesign> {
  //const Bottomsheet({ Key key }) : super(key: key);
  final BagDetailController controller = Get.put(BagDetailController());
  final LoadDetailController loadcontroller = Get.put(LoadDetailController());
  final HwabDetailController hwabDetailController =
      Get.put(HwabDetailController());
  String _scanBarcode = 'Unknown';
  String caption = '';
  String loader = 'loading';
  GetStorage storage = GetStorage();
  final textController = TextEditingController();
  clearvalue() {
    textController.text = '';
  }

  @override
  void initState() {
    super.initState();
    bottomloader();
  }

  Future<void> bottomloader() async {
    // super.didChangeDependencies();
    controller.clearvalue();

    // var output = await hwabDetailController.HwabData(Configg.lastmile);
    var output = storage.read('create_hwab');
    if (output['is_new_bag'].toString() == '0'.toString()) {
      print('1');
      caption = 'Existing Bag Created';
    } else {
      print('2');
      caption = 'New Bag Created';
    }
    if (output['bag_id'].toString() == '0'.toString()) {
      print('1');
      var output1 = await controller.BaglableData(
          // '31'
          hwabDetailController.BagDetailModel.value == null
              ? ''
              : hwabDetailController.BagDetailModel.value.tempBagId.toString());
      print('11');
      print(output1);
      if (output1['status'] == 'error') {
        print('error');
        Get.toNamed(RoutesApp.Hwabpage);
        return Utils.showMessage(message: output1['html_message']);
      }
    } else {
      print('2');
      var output1 = await controller.BaglableData(
          // '31'
          hwabDetailController.BagDetailModel.value == null
              ? ''
              : hwabDetailController.BagDetailModel.value.bagId.toString());
      print('22');
      print(output1);
      if (output1['status'] == 'error') {
        Get.toNamed(RoutesApp.Hwabpage);
        return Utils.showMessage(message: output1['html_message']);
      }
    }
    storage.remove('create_hwab');
    super.setState(() {}); // to update widget data
  }

  Future<void> scanBarcodeNormal(context) async {
    String textcontroller = textController.text.toString();
    // String barcodeScanRes;

    // try {
    //   textcontroller = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    //   print(textcontroller);
    // } on PlatformException {
    //   textcontroller = 'Failed to get platform version.';
    // }

    if (textcontroller.toString() != "-1") {
      setState(() {
        _scanBarcode = textcontroller;
      });
      print("1");

      var output = await loadcontroller.LoadData(
          textcontroller,
          // "31"
          hwabDetailController.BagDetailModel.value == null
              ? ''
              : hwabDetailController.BagDetailModel.value.omRowId.toString());

      if (output['status'] == 'error') {
        print('error');
        Get.toNamed(RoutesApp.Hwabpage);
        return Utils.showMessage(message: output['html_message']);
        // Get.snackbar(
        //   '',
        //   output['html_message'],
        //   snackStyle: SnackStyle.FLOATING,
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Color(0xff0f1210),
        //   colorText: Color(0xffffffff),
        //   padding: EdgeInsets.symmetric(
        //     vertical: 2,
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(r
        //   content: const Text('Data Not Found.'),
        // ));
      } else if (output['status'] == 'success') {
        Get.toNamed(
          RoutesApp.Baglable,
        );
        // storage.write('Bags_Page', output);
      }
      clearvalue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return controller.isLoading == true
        ? loadingscreen()
        : SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Text(
                          caption,
                          style: PoppinsHeadingHwab,
                        )),
                  ),
                ]),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xffe5e7eb),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      // padding: EdgeInsets.only(right: 4),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: Wrap(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.country_sortname.toString() ==
                                              null
                                          ? ''
                                          : controller.country_sortname
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: ImageItlscanner(
                                      image: AppIconImage.forwardarrow,
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.last_mile_port.toString() ==
                                              null
                                          ? ''
                                          : controller.last_mile_port
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: ImageItlscanner(
                                      image: AppIconImage.forwardarrow,
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.logistics_name.toString() ==
                                              null
                                          ? ''
                                          : controller.logistics_name
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: ImageItlscanner(
                                      image: AppIconImage.forwardarrow,
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.clearance_type_label
                                                  .toString() ==
                                              null
                                          ? ''
                                          : controller.clearance_type_label
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: ImageItlscanner(
                                      image: AppIconImage.forwardarrow,
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.is_having_battery_label
                                                  .toString() ==
                                              null
                                          ? ''
                                          : controller.is_having_battery_label
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 10),
                                    child: ImageItlscanner(
                                      image: AppIconImage.forwardarrow,
                                    )),
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 10),
                                  child: Obx(() => Text(
                                      controller.csb_type_label.toString() ==
                                              null
                                          ? ''
                                          : controller.csb_type_label
                                              .toString(),
                                      style: usa)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                                width: 56,
                                height: 24,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xffe5e7eb),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  Variable.bagid,
                                  style: bagid,
                                )),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 0,
                            child: Obx(() => Text(
                                controller.bag_barcode.toString() == null
                                    ? ''
                                    : controller.bag_barcode.toString(),
                                style: text)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            Variable.scanbag,
                            style: HWAB,
                          )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                          autofocus: true,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: textController,
                          onChanged: (value) => scanBarcodeNormal(context),
                          minLines: 1,
                          maxLines: 8,
                          // controller: controller.bagdetail,

                          // allow user to enter 5 line in textfield
                          // keyboardType: TextInputType
                          //     .multiline, // user keyboard will have a button to move cursor to next line
                          // controller: _Textcontroller,
                          decoration: InputDecoration(
                            isDense: true,
                            // contentPadding:
                            //     EdgeInsets.only(left: 15, top: 56, bottom: 56),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(
                                  color: Color(0xffd1d5db), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(
                                  color: Color(0xffd1d5db), width: 1),
                            ),
                            hintText: Variable.Scanhere,
                            filled: true,
                            fillColor: Color(0xffffffff),
                          )),
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   child: TextFormField(
                    //       controller: textController,
                    //       onChanged: (value) => scanBarcodeNormal(context),
                    //       minLines: 1,
                    //       maxLines: 8,
                    //       // controller: controller.bagdetail,

                    //       // allow user to enter 5 line in textfield
                    //       keyboardType: TextInputType
                    //           .multiline, // user keyboard will have a button to move cursor to next line
                    //       // controller: _Textcontroller,
                    //       decoration: InputDecoration(
                    //         isDense: true,
                    //         // contentPadding:
                    //         //     EdgeInsets.only(left: 15, top: 56, bottom: 56),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(6.0)),
                    //           borderSide: BorderSide(
                    //               color: Color(0xffd1d5db), width: 1),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(6.0)),
                    //           borderSide: BorderSide(
                    //               color: Color(0xffd1d5db), width: 1),
                    //         ),
                    //         filled: true,
                    //         fillColor: Color(0xffffffff),
                    //       )),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     scanBarcodeNormal(context);
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.83,
                    //     padding: EdgeInsets.only(top: 10, bottom: 10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(6),
                    //         border: Border.all(
                    //           color: Color(0xffd1d5db),
                    //           width: 1,
                    //         ),
                    //         color: Color(0xfffffff)),
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
                    //             )),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 150),
                    SizedBox(
                      height: 90,
                    )
                  ],
                )
              ],
            ),
          );
  }
}

void snakker(context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: const Text('Data Not Found.'),
  ));
}

void _showToast(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Updating..'),
    ),
  );
}
