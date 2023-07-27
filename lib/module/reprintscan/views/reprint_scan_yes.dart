import 'dart:convert';
import 'dart:io';
import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/base_64_custom.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/loading.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/core/utilities/widget_utilities/loadingscreen.dart';
import 'package:xborders/module/reprintscan/controller/GetWDdetails_controller.dart';
import 'package:xborders/module/reprintscan/controller/print_document_controller.dart';
import 'package:xborders/module/reprintscan/controller/reprint_controller.dart';
import 'package:xborders/module/reprintscan/controller/update_damage_controller.dart';
import 'package:xborders/module/reprintscan/widget/bottomsheetpdf.dart';
import 'package:xborders/module/reprintscan/widget/reprintscan_no.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:get_storage/get_storage.dart';

class Reprintyes extends StatefulWidget {
  const Reprintyes({Key key}) : super(key: key);

  @override
  _ReprintyesState createState() => _ReprintyesState();
}

class _ReprintyesState extends State<Reprintyes> {
  final reprintDetailController reprintscanDetailController =
      Get.put(reprintDetailController());

  final ReprintdamageController reprintdamageController =
      Get.put(ReprintdamageController());

  final printdocument printController = Get.put(printdocument());

  var kDefaultPadding = 50.0;
  var kDefaultPadding1 = 18.0;
  var selectedIndex = 0;

  List shipmentdamageyn = [
    "Yes",
    "No",
  ];

  var securitywhite = securityWhitestyle;

  var securityBlack = securityblackestyle;
  var active_tab = 1.obs;

  void changecss() {
    securitywhite = securityblackestyle;
    securityBlack = securityWhitestyle;
    active_tab.value = 2;
  }

  void changecss1() {
    securitywhite = securityWhitestyle;
    securityBlack = securityblackestyle;
    active_tab.value = 1;
  }

  List categories1 = [
    "Approve",
    "Reject",
  ];
  dynamic word1 = '';
  dynamic word2 = '';
  String img = '';

  Widget pending = Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Color(0xffff5a3a)),
  );

  Widget approved = Container(
    padding: EdgeInsets.only(left: 1),
    child: Row(
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff36b27e)),
            )
          ],
        ),
      ],
    ),
  );

  void initState() {
    super.initState();
    reprintyes();
    setState(() {});
  }

  GetStorage storage = GetStorage();
  Future<void> reprintyes() async {
    var output = await reprintscanDetailController.ReprintData(Config.awb);
    //var output = storage.read('Reprintscan');
    reprintscanDetailController.ReprintModel.value =
        storage.read('Reprintscan');
    print(Config.awb);
    if (output.value.ccSecurityCheck.toString() == '1'.toString()) {
      changecss1();
      active_tab.value = 1;
    } else {
      changecss();
      active_tab.value = 2;
    }

    if (reprintscanDetailController.ReprintModel.value.isDamage.toString() ==
        '0'.toString()) {
      selectedIndex = 1;
    } else {
      selectedIndex = 0;
    }
    print(output['document_1_status'].toString());
    if (output['document_1_status'].toString() == '0') {
      print("1t656576t");
      word1 = 'Pending';
    } else {
      word1 = 'Approved';
    }

    if (output['document_2_status'].toString() == '0') {
      print("1t656576t");
      word2 = 'Pending';
    } else {
      word2 = 'Approved';
    }

    if (output['print_label_link'].toString() == "".toString()) {
      img = 'assets/icons/1.png';
    } else {
      img = 'assets/icons/print2.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => reprintscanDetailController.isLoading == true
        ? loadingscreen()
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: Colors.black,
                )),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 19.0, top: 24),
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: IconButton(
                                    onPressed: () {
                                      Get.offAllNamed(RoutesApp.reprintscan);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 24,
                                      color: Color(0xff1f2937),
                                    )),
                              )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 24),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                alignment: Alignment.topLeft,
                                child: Text(
                                  Variable.reprintscan +
                                      "(" +
                                      reprintscanDetailController.ReprintModel
                                          .value.totalPrintLabelCount +
                                      "/" +
                                      reprintscanDetailController.ReprintModel
                                          .value.totalPrintLabelCount +
                                      ")",
                                  style: PoppinsHeading,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, right: 20),
                          child: InkWell(
                            onTap: () async {
                              if (reprintscanDetailController
                                      .ReprintModel.value.printLabelLink ==
                                  '') {
                                Utils.showMessage(
                                    message: "No Data to Display");
                              } else {
                                Base64Custom.viewPdfUrl(
                                    url: reprintscanDetailController
                                        .ReprintModel.value.printLabelLink);
                              }
                            },
                            child: Container(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  img,
                                  height: 24.9,
                                  width: 24,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                'AWB',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Inter-Medium',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff374151)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffd1d5db)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                              ),
                              padding: EdgeInsets.only(
                                  left: 15, top: 18, bottom: 18),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Text(Config.awb),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(Variable.shipmentdamage,
                                style: PoppinsHeading),
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 48,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shipmentdamageyn.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 112,
                                      width: 152,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      decoration: BoxDecoration(
                                        color: index == selectedIndex
                                            ? Color(0xff0049b0)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            kDefaultPadding),
                                        border: Border.all(
                                            color: Color(0xffe5e7eb)),
                                      ),
                                      child: Text(
                                        shipmentdamageyn[index],
                                        style: TextStyle(
                                          color: index == selectedIndex
                                              ? Colors.white
                                              : Color(0xff1f2937),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        SingleChildScrollView(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xfff3f4f6),
                              ),
                              child: SingleChildScrollView(
                                  child: Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: Column(
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      child: ImageItlscanner(
                                                        image: AppIconImage
                                                            .security,
                                                        boxFit: BoxFit.fill,
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(
                                                        Variable.Security_Check,
                                                        style: security,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 35,
                                                    ),
                                                    Obx(() => InkWell(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          splashFactory: NoSplash
                                                              .splashFactory,
                                                          onTap: () =>
                                                              changecss1(),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: active_tab
                                                                            .value ==
                                                                        1
                                                                    ? Color(
                                                                        0xff36b27e)
                                                                    : Colors
                                                                        .white,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            50)),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffd1d5db))),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.28,
                                                            child: Text(
                                                              Variable.Approve,
                                                              style:
                                                                  securitywhite,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Obx(() => InkWell(
                                                          highlightColor: Colors
                                                              .transparent,
                                                          splashFactory: NoSplash
                                                              .splashFactory,
                                                          onTap: () =>
                                                              changecss(),
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: active_tab.value == 2
                                                                      ? Color(
                                                                          0xff36b27e)
                                                                      : Colors
                                                                          .white,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          50)),
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xffd1d5db))),
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.28,
                                                              child: Text(
                                                                Variable.Reject,
                                                                style:
                                                                    securityBlack,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      selectedIndex.toString() != '0'
                                          ? Column(
                                              children: [
                                                Card(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          child: Text(
                                                            Variable.paperwork,
                                                            style:
                                                                phonenumberstyle,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 22,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        color: Color(
                                                                            0xffeae6ff)),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icons/invoice.png',
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                    )),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.42,
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .invoice,
                                                                          style:
                                                                              phonenumberstyle,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width *
                                                                                0.19,
                                                                            child:
                                                                                Text(word1, style: InterHeading)),
                                                                        word1 ==
                                                                                'Pending'
                                                                            ? pending
                                                                            : approved
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            78.0),
                                                                child: reprintscanDetailController
                                                                            .ReprintModel
                                                                            .value
                                                                            .customerInvoiceFileName !=
                                                                        ''
                                                                    ? ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          // Get.dialog(Column(
                                                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                                                          //     crossAxisAlignment: CrossAxisAlignment.center,
                                                                          //     mainAxisSize: MainAxisSize.min,
                                                                          //     children: [
                                                                          //       LoaderButton()
                                                                          //     ]));
                                                                          await Base64Custom.viewPdfUrl(
                                                                              url: reprintscanDetailController.ReprintModel.value.customerInvoiceFileName);

                                                                          //Get.back();
                                                                          // else {
                                                                          //   return '';
                                                                          // }
                                                                        },
                                                                        child: Container(
                                                                            width: MediaQuery.of(context).size.width * 0.2,
                                                                            child: Center(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                                                                              child: Text(
                                                                                Variable.view,
                                                                                style: view,
                                                                              ),
                                                                            ))),
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                              ),
                                                                            )))
                                                                    : ElevatedButton(
                                                                        onPressed: () {
                                                                          Utils.showMessage(
                                                                              message: "No Data to Display");
                                                                        },
                                                                        child: Container(
                                                                            width: MediaQuery.of(context).size.width * 0.2,
                                                                            child: Center(
                                                                                child: Padding(
                                                                              padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                                                                              child: Text(
                                                                                Variable.view,
                                                                                style: view,
                                                                              ),
                                                                            ))),
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                                                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                              RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                              ),
                                                                            )))),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 28,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        color: Color(
                                                                            0xffe5fcff)),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icons/gst.png',
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                    )),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.42,
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .gst,
                                                                          style:
                                                                              phonenumberstyle,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.19,
                                                                            child: Text(word2,
                                                                                // reprintscanDetailController.ReprintModel.value == null
                                                                                //     ? ''
                                                                                //     : word,
                                                                                style: InterHeading)),
                                                                        word2 ==
                                                                                'Pending'
                                                                            ? pending
                                                                            : approved
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          78.0),
                                                              child: ElevatedButton(
                                                                  onPressed: () async {
                                                                    Get.dialog(Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          LoaderButton()
                                                                        ]));

                                                                    // _showModalBottomSheet(context,Variable.Letter,'document_6');
                                                                    var output =
                                                                        await printController.printData(
                                                                            'document_3',
                                                                            3);
                                                                    Get.back();
                                                                    if (output[
                                                                            'status'] ==
                                                                        'success') {
                                                                      _showModalBottomSheet(
                                                                          context,
                                                                          Variable
                                                                              .gst,
                                                                          printController
                                                                              .printmodel
                                                                              .value
                                                                              .uploadPreview
                                                                              .toString());

                                                                      print(printController
                                                                          .printmodel
                                                                          .value
                                                                          .uploadPreview
                                                                          .toString());
                                                                    } else {}
                                                                  },
                                                                  child: Container(
                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                      child: Center(
                                                                          child: Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            bottom:
                                                                                12),
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .view,
                                                                          style:
                                                                              view,
                                                                        ),
                                                                      ))),
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                      ))),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 28,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        color: Color(
                                                                            0xffe3fcef)),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icons/iec.png',
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                    )),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.42,
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .iec,
                                                                          style:
                                                                              phonenumberstyle,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width *
                                                                                0.19,
                                                                            child:
                                                                                Text(word2, style: InterHeading)),
                                                                        word2 ==
                                                                                'Pending'
                                                                            ? pending
                                                                            : approved
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          78.0),
                                                              child: ElevatedButton(
                                                                  onPressed: () async {
                                                                    Get.dialog(Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          LoaderButton()
                                                                        ]));
                                                                    var output =
                                                                        await printController.printData(
                                                                            'document_4',
                                                                            3);
                                                                    Get.back();
                                                                    if (output[
                                                                            'status'] ==
                                                                        'success') {
                                                                      _showModalBottomSheet(
                                                                          context,
                                                                          Variable
                                                                              .iec,
                                                                          printController
                                                                              .printmodel
                                                                              .value
                                                                              .uploadPreview
                                                                              .toString());
                                                                    } else {
                                                                      return '';
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                      child: Center(
                                                                          child: Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            bottom:
                                                                                12),
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .view,
                                                                          style:
                                                                              view,
                                                                        ),
                                                                      ))),
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                      ))),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 28,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        color: Color(
                                                                            0xffe3fcef)),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/icons/iec.png',
                                                                      height:
                                                                          25,
                                                                      width: 25,
                                                                    )),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.42,
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .Letter,
                                                                          style:
                                                                              phonenumberstyle,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width *
                                                                                0.19,
                                                                            child:
                                                                                Text(word2, style: InterHeading)),
                                                                        word2 ==
                                                                                'Pending'
                                                                            ? pending
                                                                            : approved
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          78.0),
                                                              child: ElevatedButton(
                                                                  onPressed: () async {
                                                                    Get.dialog(Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          LoaderButton()
                                                                        ]));
                                                                    var output =
                                                                        await printController.printData(
                                                                            'document_6',
                                                                            3);
                                                                    Get.back();
                                                                    if (output[
                                                                            'status'] ==
                                                                        'success') {
                                                                      print(
                                                                          output);
                                                                      _showModalBottomSheet(
                                                                          context,
                                                                          Variable
                                                                              .Letter,
                                                                          printController
                                                                              .printmodel
                                                                              .value
                                                                              .uploadPreview
                                                                              .toString());
                                                                    } else {
                                                                      return '';
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                      child: Center(
                                                                          child: Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            top:
                                                                                12.0,
                                                                            bottom:
                                                                                12),
                                                                        child:
                                                                            Text(
                                                                          Variable
                                                                              .view,
                                                                          style:
                                                                              view,
                                                                        ),
                                                                      ))),
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                      ))),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 28,
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 18,
                                                              ),
                                                              child:
                                                                  ImageItlscanner(
                                                                image:
                                                                    AppIconImage
                                                                        .weight,
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.only(
                                                                        left:
                                                                            18,
                                                                        top: 18,
                                                                      ),
                                                                      child: Text(
                                                                        Variable
                                                                            .weightmismatch,
                                                                        style:
                                                                            weight,
                                                                      )),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                            left:
                                                                                18,
                                                                          ),
                                                                          child: Text(
                                                                            Variable.weight,
                                                                            style:
                                                                                InterHeading,
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                        child:
                                                                            Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left: 3,
                                                                      ),
                                                                      child: Obx(() => Text(
                                                                          reprintscanDetailController.ReprintModel.value == null
                                                                              ? ''
                                                                              : reprintscanDetailController.ReprintModel.value.finalPhyWeight
                                                                                  .toString(),
                                                                          style:
                                                                              InterHeading)),
                                                                    )),
                                                                    Container(
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                              left: 3,
                                                                            ),
                                                                            child: Text('kg', style: InterHeading))),
                                                                    Container(
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                            left:
                                                                                18,
                                                                          ),
                                                                          child: Text(
                                                                            Variable.vol,
                                                                            style:
                                                                                InterHeading,
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                        child:
                                                                            Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left: 3,
                                                                      ),
                                                                      child: Obx(() => Text(
                                                                          reprintscanDetailController.ReprintModel.value == null
                                                                              ? ''
                                                                              : reprintscanDetailController.ReprintModel.value.volWeight
                                                                                  .toString(),
                                                                          style:
                                                                              InterHeading)),
                                                                    )),
                                                                    Container(
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.only(
                                                                              left: 3,
                                                                            ),
                                                                            child: Text('kg', style: InterHeading))),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 22,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25),
                                                                  color: Color(
                                                                      0xff36b27e),
                                                                ),
                                                                height: 32,
                                                                width: 88,
                                                                child: InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    Get.dialog(Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          LoaderButton()
                                                                        ]));
                                                                    await Get.put(
                                                                            GetWDDetailController())
                                                                        .GetWDData(
                                                                            Config.omid);
                                                                    Get.back();
                                                                    await showSlidingBottomSheet(
                                                                        context,
                                                                        builder: (context) => SlidingSheetDialog(
                                                                            cornerRadius: 16,
                                                                            snapSpec: SnapSpec(
                                                                              snappings: [
                                                                                0.9,
                                                                                1
                                                                              ],
                                                                            ),
                                                                            builder: buildSheet));
                                                                  },
                                                                  child: Text(
                                                                    Variable
                                                                        .escalate,
                                                                    style:
                                                                        InterSmall,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 18,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.92,
                                                  height: 90,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 17,
                                                          bottom: 17),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: TextFormField(
                                                          // keyboardType:
                                                          //     TextInputType
                                                          //         .numberWithOptions(
                                                          //             decimal:
                                                          //                 true),
                                                          controller:
                                                              reprintscanDetailController
                                                                  .reprintremark,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 18,
                                                                    bottom: 18),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6.0)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffd1d5db),
                                                                  width: 1.5),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6.0)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffd1d5db),
                                                                  width: 1.5),
                                                            ),
                                                            hintText:
                                                                'Enter Remark',
                                                            hintStyle:
                                                                hintstyle,
                                                            filled: true,
                                                            fillColor: Color(
                                                                0xffffffff),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Get.dialog(Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            LoaderButton()
                                                          ]));
                                                      var output =
                                                          await reprintdamageController
                                                              .ReprintdamageData(
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : '0',
                                                        Config.awb,
                                                        '1'.toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : reprintscanDetailController
                                                                .reprintremark
                                                                .text
                                                                .toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : active_tab.value
                                                                .toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : '',
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : '',
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : '',
                                                      );
                                                      Get.back();
                                                      if (output['status'] ==
                                                          'success') {
                                                        Base64Custom.viewPdfUrl(
                                                            url: reprintdamageController
                                                                .ReprintdamageModel
                                                                .value
                                                                .printLabelLink);
                                                      }
                                                    },
                                                    child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        child: Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 18.0,
                                                                  bottom: 18),
                                                          child: Text(Variable
                                                              .printandsave),
                                                        ))),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Color(
                                                                    0xff0052cc)),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                        ))),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Card(
                                                    elevation: 0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 25,
                                                        ),

                                                        // upload

                                                        Row(
                                                          children: [
                                                            InkWell(
                                                                child: Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0,
                                                                        right:
                                                                            8),
                                                                    child: Container(
                                                                        height: 178,
                                                                        width: MediaQuery.of(context).size.width * 0.4,
                                                                        padding: const EdgeInsets.only(left: 8.0),
                                                                        child: Stack(children: [
                                                                          DottedBorder(
                                                                            child:
                                                                                // file1base64 == '' ?
                                                                                Obx(
                                                                              () => Stack(
                                                                                children: [
                                                                                  reprintscanDetailController.imageFile.value.path != ''
                                                                                      ? Align(
                                                                                          alignment: Alignment(
                                                                                            1.2,
                                                                                            -1.14,
                                                                                          ),
                                                                                          child: SizedBox(
                                                                                            height: 24,
                                                                                            width: 24,
                                                                                            child: FloatingActionButton(
                                                                                              child: ImageItlscanner(
                                                                                                image: AppIconImage.close,
                                                                                                color: Colors.black,
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                              ),
                                                                                              onPressed: () {
                                                                                                reprintscanDetailController.imageFile.value = File('');
                                                                                              },
                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                                                                                              backgroundColor: Color(0xffffffff),
                                                                                              focusColor: Color(0xffffffff),

                                                                                              // mini: true,
                                                                                              // elevation: 5.0,
                                                                                            ),
                                                                                          ))
                                                                                      : Container(),
                                                                                  Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                          alignment: Alignment.center,
                                                                                          width: MediaQuery.of(context).size.width * 0.42,
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              InkWell(
                                                                                                onTap: () async {
                                                                                                  await Utils.selectImage(reprintscanDetailController.imageFile);
                                                                                                  // checkpermission_media();
                                                                                                },
                                                                                                child: Container(
                                                                                                  height: 120,
                                                                                                  child: reprintscanDetailController.ReprintModel.value.upload1Preview == "" && reprintscanDetailController.imageFile.value.path == ""
                                                                                                      ? Column(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Padding(
                                                                                                              padding: const EdgeInsets.only(top: 10),
                                                                                                              child: ImageItlscanner(
                                                                                                                image: AppIconImage.uploadimage,
                                                                                                              ),
                                                                                                            ),
                                                                                                            SizedBox(height: 15),
                                                                                                            Text(
                                                                                                              'upload Image',
                                                                                                              style: uploadimagetext,
                                                                                                            )
                                                                                                          ],
                                                                                                        )
                                                                                                      : reprintscanDetailController.imageFile.value.path == ""
                                                                                                          ? Image.network(
                                                                                                              reprintscanDetailController.ReprintModel.value.upload1Preview.toString(),

                                                                                                              //fit: BoxFit.fill,
                                                                                                            )
                                                                                                          : Image.memory(
                                                                                                              base64Decode(Base64Custom.convertImageBase64(
                                                                                                                reprintscanDetailController.imageFile.value,
                                                                                                              ).split(',')[1]),
                                                                                                              height: MediaQuery.of(context).size.height * 0.17),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 8,
                                                                                              ),
                                                                                            ],
                                                                                          )),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ])))),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0,
                                                                        right:
                                                                            8),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            178,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.4,
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0),
                                                                        child: Stack(
                                                                            children: [
                                                                              DottedBorder(
                                                                                child:
                                                                                    // file1base64 == '' ?
                                                                                    Obx(
                                                                                  () => Stack(children: [
                                                                                    reprintscanDetailController.imageFile1.value.path != ''
                                                                                        ? Align(
                                                                                            alignment: Alignment(
                                                                                              1.2,
                                                                                              -1.14,
                                                                                            ),
                                                                                            child: SizedBox(
                                                                                              height: 24,
                                                                                              width: 24,
                                                                                              child: FloatingActionButton(
                                                                                                child: ImageItlscanner(
                                                                                                  image: AppIconImage.close,
                                                                                                  height: 20,
                                                                                                  width: 20,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  reprintscanDetailController.imageFile1.value = File('');
                                                                                                },
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                                                                                                backgroundColor: Colors.white,
                                                                                                mini: true,
                                                                                                elevation: 5.0,
                                                                                              ),
                                                                                            ))
                                                                                        : Container(),
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                            alignment: Alignment.center,
                                                                                            width: MediaQuery.of(context).size.width * 0.42,
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  onTap: () async {
                                                                                                    await Utils.selectImage(reprintscanDetailController.imageFile1);
                                                                                                    // checkpermission_media();
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 120,
                                                                                                    child: reprintscanDetailController.ReprintModel.value.upload2Preview == "" && reprintscanDetailController.imageFile1.value.path == ""
                                                                                                        ? Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.only(top: 10),
                                                                                                                child: ImageItlscanner(
                                                                                                                  image: AppIconImage.uploadimage,
                                                                                                                ),
                                                                                                              ),
                                                                                                              SizedBox(height: 15),
                                                                                                              Text(
                                                                                                                'upload Image',
                                                                                                                style: uploadimagetext,
                                                                                                              )
                                                                                                            ],
                                                                                                          )
                                                                                                        : reprintscanDetailController.imageFile1.value.path == ""
                                                                                                            ? Image.network(
                                                                                                                reprintscanDetailController.ReprintModel.value.upload2Preview.toString(),

                                                                                                                //fit: BoxFit.fill,
                                                                                                              )
                                                                                                            : Image.memory(
                                                                                                                base64Decode(Base64Custom.convertImageBase64(
                                                                                                                  reprintscanDetailController.imageFile1.value,
                                                                                                                ).split(',')[1]),
                                                                                                                height: MediaQuery.of(context).size.height * 0.17),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 8,
                                                                                                ),
                                                                                              ],
                                                                                            )),
                                                                                      ],
                                                                                    ),
                                                                                  ]),
                                                                                ),
                                                                              ),
                                                                            ])))
                                                          ],
                                                        ),
                                                        ////////
                                                        ///
                                                        ///
                                                        ///
                                                        ///
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0,
                                                                        right:
                                                                            8),
                                                                child:
                                                                    Container(
                                                                        height:
                                                                            178,
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.4,
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            DottedBorder(
                                                                              child:
                                                                                  // file1base64 == '' ?
                                                                                  Obx(
                                                                                () => Stack(
                                                                                  children: [
                                                                                    reprintscanDetailController.imageFile2.value.path != ''
                                                                                        ? Align(
                                                                                            alignment: Alignment(
                                                                                              1.2,
                                                                                              -1.14,
                                                                                            ),
                                                                                            child: SizedBox(
                                                                                              height: 24,
                                                                                              width: 24,
                                                                                              child: FloatingActionButton(
                                                                                                child: ImageItlscanner(
                                                                                                  image: AppIconImage.close,
                                                                                                  height: 20,
                                                                                                  width: 20,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  reprintscanDetailController.imageFile2.value = File('');
                                                                                                },
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
                                                                                                backgroundColor: Colors.white,
                                                                                                mini: true,
                                                                                                elevation: 5.0,
                                                                                              ),
                                                                                            ))
                                                                                        : Container(),
                                                                                    Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Container(
                                                                                            alignment: Alignment.center,
                                                                                            width: MediaQuery.of(context).size.width * 0.42,
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  onTap: () async {
                                                                                                    await Utils.selectImage(reprintscanDetailController.imageFile2);
                                                                                                    // checkpermission_media();
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 120,
                                                                                                    child: reprintscanDetailController.ReprintModel.value.upload3Preview == "" && reprintscanDetailController.imageFile2.value.path == ""
                                                                                                        ? Column(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              Padding(
                                                                                                                padding: const EdgeInsets.only(top: 10),
                                                                                                                child: ImageItlscanner(
                                                                                                                  image: AppIconImage.uploadimage,
                                                                                                                ),
                                                                                                              ),
                                                                                                              SizedBox(height: 15),
                                                                                                              Text(
                                                                                                                'upload Image',
                                                                                                                style: uploadimagetext,
                                                                                                              )
                                                                                                            ],
                                                                                                          )
                                                                                                        : reprintscanDetailController.imageFile2.value.path == ""
                                                                                                            ? Image.network(
                                                                                                                reprintscanDetailController.ReprintModel.value.upload3Preview.toString(),

                                                                                                                //fit: BoxFit.fill,
                                                                                                              )
                                                                                                            : Image.memory(
                                                                                                                base64Decode(Base64Custom.convertImageBase64(
                                                                                                                  reprintscanDetailController.imageFile2.value,
                                                                                                                ).split(',')[1]),
                                                                                                                height: MediaQuery.of(context).size.height * 0.17),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 8,
                                                                                                ),
                                                                                              ],
                                                                                            )),
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )))
                                                          ],
                                                        ),

                                                        // last
                                                        SizedBox(
                                                          height: 22,
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.92,
                                                  height: 90,
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 17,
                                                          bottom: 17),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: TextFormField(
                                                          controller:
                                                              reprintscanDetailController
                                                                  .reprintremark,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    top: 18,
                                                                    bottom: 18),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6.0)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffd1d5db),
                                                                  width: 1.5),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          6.0)),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffd1d5db),
                                                                  width: 1.5),
                                                            ),
                                                            hintText:
                                                                'Enter Remark',
                                                            hintStyle:
                                                                hintstyle,
                                                            filled: true,
                                                            fillColor: Color(
                                                                0xffffffff),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      Get.dialog(Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            LoaderButton()
                                                          ]));

                                                      var result = await Get.put(
                                                              ReprintdamageController())
                                                          .ReprintdamageData(
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : '1',
                                                        Config.awb,
                                                        '1'.toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : reprintscanDetailController
                                                                .reprintremark
                                                                .text
                                                                .toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : active_tab.value
                                                                .toString(),
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : reprintscanDetailController
                                                                        .imageFile
                                                                        .value
                                                                        .path !=
                                                                    ''
                                                                ? reprintscanDetailController
                                                                    .imageFile
                                                                    .value
                                                                : '',
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : reprintscanDetailController
                                                                        .imageFile1
                                                                        .value
                                                                        .path !=
                                                                    ''
                                                                ? reprintscanDetailController
                                                                    .imageFile1
                                                                    .value
                                                                : '',
                                                        reprintscanDetailController
                                                                    .ReprintModel
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : reprintscanDetailController
                                                                        .imageFile2
                                                                        .value
                                                                        .path !=
                                                                    ''
                                                                ? reprintscanDetailController
                                                                    .imageFile2
                                                                    .value
                                                                : '',
                                                      );
                                                      Get.back();
                                                      reprintscanDetailController
                                                          .imageFile
                                                          .value = File('');
                                                      reprintscanDetailController
                                                          .imageFile1
                                                          .value = File("");
                                                      reprintscanDetailController
                                                          .imageFile2
                                                          .value = File("");

                                                      Get.offNamed(RoutesApp
                                                          .reprintscan);
                                                      Utils.showMessage(
                                                          message: result[
                                                              'html_message']);
                                                      // ScaffoldMessenger.of(
                                                      //         context)
                                                      //     .showSnackBar(
                                                      //         SnackBar(
                                                      //   content: const Text(
                                                      //       'Reprint Data Updated Successfully'),
                                                      // ));
                                                    },
                                                    child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        child: Center(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 18.0,
                                                                  bottom: 18),
                                                          child: Text(
                                                              Variable.submit),
                                                        ))),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Color(
                                                                    0xff0052cc)),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                          ),
                                                        ))),
                                                SizedBox(
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ]))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
  }

  Widget buildSheetpdf(context, State) => Material(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Bottomsheetpdff(
              word: Variable.Letter,
            )
            // Bottomsheet()
          ],
        ),
      );

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}

_showModalBottomSheet(context, word, word2) {
  print('1234');
  // printdocument controller = printdocument();
  printdocument printController = Get.put(printdocument());

  @override
  void didChangeDependencies() async {
    printdocument().printData('document_6', 3);

    print('object756756645456456454');
    print(printController.printmodel.value.uploadPreview.toString());
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.95,
        child: SingleChildScrollView(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    word,
                    style: PoppinsHeadingHwab,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                child: ImageItlscanner(
                  image: AppIconImage.print,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: InkWell(
                  child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 21,
                  color: Color(0xff374151),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ImageItlscanner(
                  image: AppIconImage.close,
                ),
              ),
            ),
          ]),
          Column(children: [
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Color(0xffe5e7eb),
            ),
            SizedBox(
              height: 50,
            ),
            Container(child: Image.memory(base64Decode(word2.split(',')[1]))),
          ]),
          SizedBox(
            height: 40,
          ),
          // Container(
          //       child: Image.memory(base64Decode(
          //         printdocument().printmodel.value.uploadPreview.toString()
          //     // printController.printmodel.value.uploadPreview.toString(),
          //   )

          //   )),
        ])),
      );
    },
  );
}

class Bottomsheett extends StatefulWidget {
  const Bottomsheett({Key key}) : super(key: key);

  @override
  State<Bottomsheett> createState() => _BottomsheettState();
}

class _BottomsheettState extends State<Bottomsheett> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
