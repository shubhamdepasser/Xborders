// import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
// import 'package:xborders/core/utilities/image_data/my_icons.dart';

import 'dart:io';

import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/base_64_custom.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/loading.dart';
import 'package:xborders/core/utilities/packages/pdf_viewer.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/core/utilities/widget_utilities/loadingscreen.dart';
import 'package:xborders/module/hwabscan/controller/baglable_controller.dart';
import 'package:xborders/module/hwabscan/controller/hwabscan_controller.dart';
import 'package:xborders/module/hwabscan/controller/pdf_controller.dart';
import 'package:xborders/module/hwabscan/controller/submit_controller.dart';
import 'package:xborders/module/hwabscan/controller/unload_controller.dart';
import 'package:xborders/module/hwabscan/widget/baglable_card.dart';
import 'package:xborders/module/hwabscan/widget/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xborders/core/api/config/config.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:readmore/readmore.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:get/get.dart';

// class Greencard {
//   final String caption1;
//   final String caption2;
//   Greencard(
//     this.caption1,
//     this.caption2,
//   );

//   Greencard.fromJson(Map<String, dynamic> json)
//       : caption1 = json['caption1'],
//         caption2 = json['caption2'];

//   Map<String, dynamic> toJson() => {
//         'caption1': caption1,
//         'caption2': caption2,
//       };
// }

class baglable extends StatefulWidget {
  @override
  _baglableState createState() => _baglableState();
}

class _baglableState extends State<baglable> {
  String validatehawb(value) {
    if (value.isEmpty) {
      return "Please Add Mawb Number";
    }
    // }
    else {
      return null;
    }
  }

  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  final BagDetailController controller = Get.put(BagDetailController());
  final PdfController pdfcontroller = Get.put(PdfController());
  final HwabDetailController hwabDetailController =
      Get.put(HwabDetailController());
  List data = [].obs;
  RxBool is_om_row_data = false.obs;

  // PDFDocument document;
  // var loader = 'loading';
  var is_pdf = 0;
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  //  Greencard us = Greencard("assets/icons/loading.png", "In Progress");

  // Future<void> getpdfviewer() async {
  //   print("hello");
  //   document = await PDFDocument.fromURL(
  //       "https://itl-outbound-web-app-uploads-test.s3.ap-south-1.amazonaws.com/uploads/bag/bag_label/3f2ab3f832233b4354c52799fb19ff8a.pdf");
  //       is_pdf = 1;
  //       setState(() {
  //         is_pdf = 1;
  //       });

  // }
  // List<ListItem> listItems =
  //     List.generate(4, (int index) => ListItem(4, false));

  // _expandItem(ListItem listItem) {
  //   setState(() {
  //     listItems.forEach((ListItem item) {
  //       if (item == listItem) {
  //         item.expanded = !item.expanded;
  //       } else {
  //         item.expanded = false;
  //       }
  //     });
  //   });
  // }
  //text editing controller for text field
  Future<void> doSomeAsyncStuff() async {
    controller.clearvalue();
    var output = await hwabDetailController.HwabData(Configg.lastmile);
    if (output['bag_id'] == '0') {
      print("sfdjfkfh");
      await controller.BaglableData(
          // '31'
          hwabDetailController.BagDetailModel.value == null
              ? ''
              : hwabDetailController.BagDetailModel.value.tempBagId.toString());
    } else {
      print("1111111111111");
      await controller.BaglableData(
          // '31'
          hwabDetailController.BagDetailModel.value == null
              ? output['bag_id']
              : output['bag_id']);
      //  data.add(controller.userModel.value.omDataArray);

    }
    
    data = controller.userModel.value.omDataArray;
    is_om_row_data.value = true;

    setState(() {});

    Configg.printer = await pdfcontroller.PdfData(
        controller.userModel.value == null
            ? ''
            : controller.userModel.value.bagRowId.toString());
  }

  void initState() {
    super.initState();
    doSomeAsyncStuff();
    setState(() {
      data = controller.userModel.value.omDataArray;
    });
  }

  Future<void> removeitem(id) async {
    doSomeAsyncStuff();

    var unloadoutput = await Get.put(UnloadController()).unloadData(
      id,
    );
    is_om_row_data.value = false;

    if (true) {
      data.removeWhere((element) => element.id == id);
      data = data;
      is_om_row_data.value = true;
      if (unloadoutput['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Deleted Successfully'),
        ));
      } else if (unloadoutput['status'] == 'error') {
        Get.snackbar(
          '',
          'Data Not Found',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color(0xff0f1210),
          colorText: Color(0xffffffff),
          padding: EdgeInsets.symmetric(
            vertical: 2,
          ),
        );
      } else {
        return '';
      }
    }
    setState(() {});
  }
    Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    Get.offAllNamed(RoutesApp.Hwabpage);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    bool showmore = false;
    return WillPopScope(
        onWillPop: () => _willPopCallback(),
        child: Obx(
          () => Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: AppBar(
                    // Here we create one to set status bar color
                    backgroundColor: Colors
                        .black, // Set any color of status bar you want; or it defaults to your theme's primary color
                  )),
              body: controller.isLoading == true ||
                      hwabDetailController.isLoading == true
                  ? loadingscreen()
                  : SingleChildScrollView(
                      child: Form(
                        // key: formkey,
                        child: Column(children: [
                          SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 24),
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          // if(storage.read('Bag_Page') == 1){
                                          //   Get.back();
                                          //   Get.back();
                                          // }else{
                                          //   Get.back();
                                          // }

                                          Get.offAllNamed(RoutesApp.Hwabpage);
                                          //  Get.back();
                                          Configg.lastmile = '';
                                        },
                                        child: ImageItlscanner(
                                          image: AppIconImage.back,
                                        ))),
                              ),
                              Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, top: 24),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.66,
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Variable.hwab,
                                        style: PoppinsHeadingHwab,
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, right: 20),
                                child: InkWell(
                                  onTap: () {
                                    Base64Custom.viewPdfUrl(
                                        url: pdfcontroller
                                            .PdfModel.value.bagLabelS3Url);
                                    // pdfcontroller.showpdf.toString() == null
                                    //     ? ''
                                    //     : pdfcontroller.showpdf.toString());
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: ImageItlscanner(
                                        image: AppIconImage.print,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Row(
                                    children: [
                                      Text(
                                        Variable.Enterhawb,
                                        style: Hwab,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(right: 1.0),
                                  child: Container(
                                    height: 56,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: Color(0xffffffff),
                                        border: Border.all(
                                            color: Color(0xffd1d5db))),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, left: 5),
                                        child: Text(Configg.lastmile.toString(),
                                            style: usa)),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 9,
                                  // padding: EdgeInsets.only(right: 4),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 9, left: 7, right: 3),
                                    child: Wrap(
                                      children: [
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.country_sortname
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .country_sortname
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
                                                  image:
                                                      AppIconImage.forwardarrow,
                                                )),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.last_mile_port
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .last_mile_port
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
                                                  image:
                                                      AppIconImage.forwardarrow,
                                                )),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.logistics_name
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .logistics_name
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
                                                  image:
                                                      AppIconImage.forwardarrow,
                                                )),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.clearance_type_label
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .clearance_type_label
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
                                                  image:
                                                      AppIconImage.forwardarrow,
                                                )),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.is_having_battery_label
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .is_having_battery_label
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
                                                  image:
                                                      AppIconImage.forwardarrow,
                                                )),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 10),
                                              child: Obx(() => Text(
                                                  controller.csb_type_label
                                                              .toString() ==
                                                          null
                                                      ? ''
                                                      : controller
                                                          .csb_type_label
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
                                  height: 25,
                                ),
                                Obx(() => is_om_row_data == false
                                    ? Container()
                                    : Column(
                                        children: data
                                            .map<Widget>((e) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.89,
                                                child: Card(
                                                    color: Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.45,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20.0),
                                                            child: Text(
                                                              e.lastMileAwb
                                                                  .toString(),
                                                              style: hwabcard,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 14,
                                                              ),
                                                              Text(
                                                                'Wt',
                                                                style: hwabcard,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                e.finalPhyWeight
                                                                    .toString(),
                                                                style: hwabcard,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                'KG',
                                                                style: hwabcard,
                                                              ),
                                                              controller
                                                                          .userModel
                                                                          .value
                                                                          .isBagClosed !=
                                                                      1.toString()
                                                                  ? Expanded(
                                                                      flex: 0,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 10.0),
                                                                        child: InkWell(
                                                                            onTap: () {
                                                                              showDialog<String>(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) => AlertDialog(
                                                                                          title: Text(
                                                                                            'Remove HAWB?',
                                                                                            style: PoppinsHeadingHwab,
                                                                                          ),
                                                                                          content: const Text('Are you sure want to remove HAWB number?'),
                                                                                          actions: <Widget>[
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context, 'Yes');
                                                                                                removeitem(e.id);
                                                                                              },
                                                                                              child: const Text('Yes'),
                                                                                            ),
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context, 'No');
                                                                                              },
                                                                                              child: const Text('No'),
                                                                                            ),
                                                                                          ]));
                                                                            },
                                                                            child: Icon(
                                                                              Icons.close,
                                                                              color: Color(0xffffffff),
                                                                            )),
                                                                      ),
                                                                    )
                                                                  : Container(),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ))))
                                            .toList()
                                            .reversed
                                            .toList(),
                                      )),
                                SizedBox(height: 25),
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 56,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe5e7eb),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            Variable.bagid,
                                            style: bagid,
                                          )),
                                      SizedBox(width: 12),
                                      Expanded(
                                        flex: 0,
                                        child: Obx(() => Text(
                                            controller.bag_barcode.toString() ==
                                                    null
                                                ? ''
                                                : controller.bag_barcode
                                                    .toString(),
                                            style: text)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 88,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Color(0xffe5e7eb),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                            Variable.bagweigth,
                                            style: bagid,
                                          )),
                                      SizedBox(width: 15),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: Obx(() => Text(
                                                controller.bag_weight
                                                            .toString() ==
                                                        null
                                                    ? ''
                                                    : controller.bag_weight
                                                        .toString(),
                                                style: text)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              'KG',
                                              style: text,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Row(
                                    children: [
                                      Text(
                                        Variable.MAWBnumber,
                                        style: Hwab,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 08),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    minLines: 1,
                                    controller: controller.airlinenumb,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 15, top: 20, bottom: 20),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffd1d5db), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0)),
                                        borderSide: BorderSide(
                                            color: Color(0xffd1d5db), width: 1),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xffffffff),
                                    ),
                                    validator: validatehawb,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.only(left: 18),
                                  child: Row(
                                    children: [
                                      Text(
                                        Variable.bagdetails,
                                        style: Hwab,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 08),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                      minLines: 5,
                                      maxLines: 8,
                                      controller: controller.bagdetail,
                                      keyboardType: TextInputType
                                          .multiline, // user keyboard will have a button to move cursor to next line
                                      decoration: InputDecoration(
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xffd1d5db),
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xffd1d5db),
                                              width: 1),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffffffff),
                                      )),
                                ),
                                SizedBox(height: 80),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff0052cc),

                                            minimumSize: Size(152, 48),
                                            elevation: 3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            //////// HERE
                                          ),
                                          onPressed: () async {
                                            // if (!formkey.currentState.validate()) {
                                            //   // widget.onSubmit(_name);
                                            //   return;
                                            // }
                                            Get.dialog(Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [LoaderButton()]));
                                            var output = await Get.put(
                                                    SubmitController())
                                                .SubmitData(
                                                    controller.userModel.value == null
                                                        ? ''
                                                        : controller.userModel
                                                            .value.bagRowId
                                                            .toString(),
                                                    controller.airlinenumb.text
                                                                .toString() ==
                                                            ''
                                                        ? ''
                                                        : controller
                                                            .airlinenumb.text
                                                            .toString(),
                                                    controller.bagdetail.text
                                                                .toString() ==
                                                            null
                                                        ? ''
                                                        : controller.bagdetail.text
                                                            .toString(),
                                                    controller.userModel.value == null
                                                        ? ''
                                                        : controller
                                                            .userModel
                                                            .value
                                                            .omDataArray
                                                            .length
                                                            .toString(),
                                                    '0');
                                            Configg.lastmile = '';
                                            if (output['status'] == 'success') {
                                              Get.offAllNamed(
                                                  RoutesApp.Hwabpage);

                                              Configg.lastmile = '';
                                              return Utils.showMessage(
                                                  message:
                                                      output['html_message']);
                                            } else if (output['status'] ==
                                                'error') {
                                              return Utils.showMessage(
                                                  message:
                                                      output['html_message']);
                                            } else {
                                              return null;
                                            }
                                          },
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //   content: const Text(
                                          //       'Data Submited Successfully'),
                                          // ));

                                          child: SizedBox(
                                              height: 20,
                                              child: Text(
                                                Variable.submit,
                                                style: submitclose,
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      controller.userModel.value.isBagClosed !=
                                              1.toString()
                                          ? Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xff0052cc),

                                                  minimumSize: Size(152, 48),
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  //////// HERE
                                                ),
                                                onPressed: () async {
                                                  // if (!formkey.currentState.validate()) {
                                                  //   // widget.onSubmit(_name);
                                                  //   return;
                                                  // }
                                                  showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                              title: Text(
                                                                Variable.alert,
                                                                style:
                                                                    PoppinsHeadingHwab,
                                                              ),
                                                              content: const Text(
                                                                  'Are you sure want to Submit and Close Bag?'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Yes');
                                                                    Get.dialog(Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          LoaderButton()
                                                                        ]));
                                                                    var output = await Get.put(SubmitController()).SubmitData(
                                                                        controller.userModel.value ==
                                                                                null
                                                                            ? ''
                                                                            : controller.userModel.value.bagRowId
                                                                                .toString(),
                                                                        controller.airlinenumb.text.toString() ==
                                                                                ''
                                                                            ? ''
                                                                            : controller.airlinenumb.text
                                                                                .toString(),
                                                                        controller.bagdetail.text.toString() ==
                                                                                null
                                                                            ? ''
                                                                            : controller.bagdetail.text
                                                                                .toString(),
                                                                        controller.userModel.value ==
                                                                                null
                                                                            ? ''
                                                                            : controller.userModel.value.omDataArray.length.toString(),
                                                                        '1');
                                                                    Configg.lastmile =
                                                                        '';
                                                                    if (output[
                                                                            'status'] ==
                                                                        'success') {
                                                                      Get.offAllNamed(
                                                                          RoutesApp
                                                                              .Hwabpage);

                                                                      Configg.lastmile =
                                                                          '';
                                                                      return Utils.showMessage(
                                                                          message:
                                                                              output['html_message']);
                                                                    } else if (output[
                                                                            'status'] ==
                                                                        'error') {
                                                                      Get.back();
                                                                      return Utils.showMessage(
                                                                          message:
                                                                              output['html_message']);
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        'No');
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                              ]));
                                                },
                                                child: SizedBox(
                                                    height: 20,
                                                    child: Text(
                                                      Variable.submitclose,
                                                      style: submitclose,
                                                    )),
                                              ),
                                            )
                                          : Container(),
                                      // Container(
                                      //   width: MediaQuery.of(context).size.width *
                                      //       0.45,
                                      //   child: ElevatedButton(
                                      //     onPressed: () {
                                      //       // if (!formkey.currentState.validate()) {
                                      //       //   // widget.onSubmit(_name);
                                      //       //   return;
                                      //       // }
                                      //       showDialog<String>(
                                      //           context: context,
                                      //           builder: (BuildContext context) =>
                                      //               AlertDialog(
                                      //                   title: Text(
                                      //                     Variable.alert,
                                      //                     style: PoppinsHeadingHwab,
                                      //                   ),
                                      //                   content: const Text(
                                      //                       'Are you sure want to Submit and Close Bag?'),
                                      //                   actions: <Widget>[
                                      //                     TextButton(
                                      //                       onPressed: () async {
                                      //                         Navigator.pop(
                                      //                             context, 'Yes');
                                      //                         Get.dialog(Column(
                                      //                             mainAxisAlignment:
                                      //                                 MainAxisAlignment
                                      //                                     .center,
                                      //                             crossAxisAlignment: CrossAxisAlignment.center,
                                      //                             mainAxisSize: MainAxisSize.min,
                                      //                             children: [
                                      //                               LoaderButton()
                                      //                             ]));
                                      //                         var result = await Get.put(SubmitController()).SubmitData(
                                      //                             controller.userModel.value == null
                                      //                                 ? ''
                                      //                                 : controller
                                      //                                     .userModel
                                      //                                     .value
                                      //                                     .bagRowId
                                      //                                     .toString(),
                                      //                             controller.airlinenumb.text.toString() == ''
                                      //                                 ? ''
                                      //                                 : controller
                                      //                                     .airlinenumb
                                      //                                     .text
                                      //                                     .toString(),
                                      //                             controller.bagdetail
                                      //                                         .text
                                      //                                         .toString() ==
                                      //                                     null
                                      //                                 ? ''
                                      //                                 : controller
                                      //                                     .bagdetail
                                      //                                     .text
                                      //                                     .toString(),
                                      //                             controller.userModel.value == null
                                      //                                 ? ''
                                      //                                 : controller
                                      //                                     .userModel
                                      //                                     .value
                                      //                                     .omDataArray
                                      //                                     .length
                                      //                                     .toString(),
                                      //                             '1');
                                      //                         Configg.lastmile = '';
                                      //                         if (result[
                                      //                                 'status'] ==
                                      //                             'success') {
                                      //                           Get.toNamed(
                                      //                               RoutesApp
                                      //                                   .Hwabpage);
                                      //                           Configg.lastmile =
                                      //                               '';
                                      //                           return Utils.showMessage(
                                      //                               message: result[
                                      //                                   'html_message']);
                                      //                         } else if (result[
                                      //                                 'status'] ==
                                      //                             'error') {
                                      //                           return Utils.showMessage(
                                      //                               message: result[
                                      //                                   'html_message']);
                                      //                         } else {
                                      //                           return null;
                                      //                         }
                                      //                       },
                                      //                       child:
                                      //                           const Text('Yes'),
                                      //                     ),
                                      //                     TextButton(
                                      //                       onPressed: () {
                                      //                         Navigator.pop(
                                      //                             context, 'No');
                                      //                       },
                                      //                       child: const Text('No'),
                                      //                     ),
                                      //                   ]));
                                      //     },
                                      //     style: ElevatedButton.styleFrom(
                                      //       primary: Color(0xff0052cc),

                                      //       minimumSize: Size(152, 48),
                                      //       elevation: 3,
                                      //       shape: RoundedRectangleBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(50.0)),
                                      //       //////// HERE
                                      //     ),
                                      //     child: SizedBox(
                                      //         height: 20,
                                      //         child: Expanded(
                                      //             flex: 0,
                                      //             child: Text(Variable.submitclose,
                                      //                 style: submitclose))),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30)
                              ],
                            ),
                          ),
                        ]),
                      ),
                    )),
        ));
  }
}
