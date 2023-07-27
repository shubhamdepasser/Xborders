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
import 'package:xborders/core/utilities/validation/validation_widget.dart';
import 'package:xborders/core/utilities/validation/validator_helpers.dart';
import 'package:xborders/core/utilities/variable.dart';

import 'package:xborders/module/reprintscan/controller/GetWDdetails_controller.dart';
import 'package:xborders/module/reprintscan/controller/UpdateWD_controller.dart';
import 'package:xborders/module/reprintscan/controller/reprint_controller.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';

class Bottomsheet extends StatefulWidget {
  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final GetWDDetailController controller = Get.put(GetWDDetailController());
  final UpdateWDController updatecontroller = Get.put(UpdateWDController());
  final reprintDetailController reprintcontroller =
      Get.put(reprintDetailController());
  GetStorage storage = GetStorage();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var reserveweight = '';
  bool isreserveweightFirstClicked = false;
  clearvalue() {}

  @override
  void initState() {
    super.initState();
    // storage.read('get_scan');
    //controller.GetWDData(Config.omid);
    // reprintcontroller.ReprintData(Config.awb);
    //storage.remove('get_scan');
    //  storage.remove('create_hwab');
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 25),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    Variable.escalateweight,
                    style: PoppinsHeadingBold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
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
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Variable.sellerweight,
                      style: InterSmallGrey,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffd1d5db)),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: Obx(() => Text(
                      reprintcontroller.ReprintModel.value == null
                          ? ''
                          : reprintcontroller.ReprintModel.value.finalPhyWeight
                              .toString()))),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Variable.yourweight,
                      style: InterSmallGrey,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  key: formkey,
                  child: TextFormField(
                      controller: controller.reserveweight,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                        new LengthLimitingTextInputFormatter(4),
                      ],
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          isreserveweightFirstClicked = false;
                        }
                        isreserveweightFirstClicked = true;
                        reserveweight = value;
                        setState(() {});
                      },
                      validator: (Value) {
                        if (Value.isEmpty) {
                          return 'Please Enter Your Weight';
                        } else {
                          return null;
                        }
                      },
// '[0-9.,]+'
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 15, top: 15, bottom: 15),
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
                        filled: true,
                        fillColor: Color(0xffffffff),
                      )),
                ),
              ),
              ValidationWidget(
                  isWidthStart: true,
                  isClicked: isreserveweightFirstClicked,
                  validationType: ValidationHelper.name,
                  isShow: isreserveweightFirstClicked == false,
                  valueInput: controller.reserveweight.text),
              SizedBox(
                height: 25,
              ),
//uploadimage

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      Variable.uploadimages,
                      style: InterSmallGrey,
                    )),
              ),
              SizedBox(
                height: 8,
              ),

              // upadte
              Row(
                children: [
                  InkWell(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 8),
                          child: Container(
                              height: 178,
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: const EdgeInsets.only(left: 8.0),
                              child: DottedBorder(
                                child:
                                    // file1base64 == '' ?
                                    Obx(
                                  () => Stack(
                                    children: [
                                      controller.imageFile.value.path != ''
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
                                                    controller.imageFile.value =
                                                        File('');
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80)),
                                                  backgroundColor: Colors.white,
                                                  mini: true,
                                                  elevation: 5.0,
                                                ),
                                              ))
                                          : Container(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.42,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      await Utils.selectImage(
                                                          controller.imageFile);
                                                      // checkpermission_media();
                                                    },
                                                    child: Container(
                                                      height: 120,
                                                      child: controller
                                                                      .GetWDModel
                                                                      .value
                                                                      .upload1Preview ==
                                                                  "" &&
                                                              controller
                                                                      .imageFile
                                                                      .value
                                                                      .path ==
                                                                  ""
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                                  child:
                                                                      ImageItlscanner(
                                                                    image: AppIconImage
                                                                        .uploadimage,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 15),
                                                                Text(
                                                                  'upload Image',
                                                                  style:
                                                                      uploadimagetext,
                                                                )
                                                              ],
                                                            )
                                                          : controller
                                                                      .imageFile
                                                                      .value
                                                                      .path ==
                                                                  ""
                                                              ? Image.network(
                                                                  controller
                                                                      .GetWDModel
                                                                      .value
                                                                      .upload1Preview
                                                                      .toString(),

                                                                  //fit: BoxFit.fill,
                                                                )
                                                              : Image.memory(
                                                                  base64Decode(
                                                                      Base64Custom
                                                                              .convertImageBase64(
                                                                    controller
                                                                        .imageFile
                                                                        .value,
                                                                  ).split(',')[
                                                                          1]),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.17),
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
                              )))),
                  Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Container(
                          height: 178,
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DottedBorder(
                            child:
                                // file1base64 == '' ?
                                Obx(
                              () => Stack(
                                children: [
                                  controller.imageFile1.value.path != ''
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
                                                controller.imageFile1.value =
                                                    File('');
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80)),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await Utils.selectImage(
                                                      controller.imageFile1);
                                                  // checkpermission_media();
                                                },
                                                child: Container(
                                                  height: 120,
                                                  child: controller
                                                                  .GetWDModel
                                                                  .value
                                                                  .upload2Preview ==
                                                              "" &&
                                                          controller.imageFile1
                                                                  .value.path ==
                                                              ""
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child:
                                                                  ImageItlscanner(
                                                                image: AppIconImage
                                                                    .uploadimage,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Text(
                                                              'upload Image',
                                                              style:
                                                                  uploadimagetext,
                                                            )
                                                          ],
                                                        )
                                                      : controller.imageFile1
                                                                  .value.path ==
                                                              ""
                                                          ? Image.network(
                                                              controller
                                                                  .GetWDModel
                                                                  .value
                                                                  .upload2Preview
                                                                  .toString(),

                                                              //fit: BoxFit.fill,
                                                            )
                                                          : Image.memory(
                                                              base64Decode(
                                                                  Base64Custom
                                                                      .convertImageBase64(
                                                                controller
                                                                    .imageFile1
                                                                    .value,
                                                              ).split(',')[1]),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.17),
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
                          )))
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
                      padding: const EdgeInsets.only(left: 12.0, right: 8),
                      child: Container(
                          height: 178,
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.only(left: 8.0),
                          child: DottedBorder(
                            child:
                                // file1base64 == '' ?
                                Obx(
                              () => Stack(
                                children: [
                                  controller.imageFile2.value.path != ''
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
                                                controller.imageFile2.value =
                                                    File('');
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80)),
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await Utils.selectImage(
                                                      controller.imageFile2);
                                                  // checkpermission_media();
                                                },
                                                child: Container(
                                                  height: 120,
                                                  child: controller
                                                                  .GetWDModel
                                                                  .value
                                                                  .upload3Preview ==
                                                              "" &&
                                                          controller.imageFile2
                                                                  .value.path ==
                                                              ""
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child:
                                                                  ImageItlscanner(
                                                                image: AppIconImage
                                                                    .uploadimage,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15),
                                                            Text(
                                                              'upload Image',
                                                              style:
                                                                  uploadimagetext,
                                                            )
                                                          ],
                                                        )
                                                      : controller.imageFile2
                                                                  .value.path ==
                                                              ""
                                                          ? Image.network(
                                                              controller
                                                                  .GetWDModel
                                                                  .value
                                                                  .upload3Preview
                                                                  .toString(),

                                                              //fit: BoxFit.fill,
                                                            )
                                                          : Image.memory(
                                                              base64Decode(
                                                                  Base64Custom
                                                                      .convertImageBase64(
                                                                controller
                                                                    .imageFile2
                                                                    .value,
                                                              ).split(',')[1]),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.17),
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
                          )))
                ],
              ),

//lastupload

              SizedBox(
                height: 65,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Get.focusScope.unfocus();

                    if (ValidationHelper.checkValidation(
                        first: controller.reserveweight.text.trim(),
                        type: ValidationHelper.name))
                      isreserveweightFirstClicked = true;
                    setState(() {});

                    if (!ValidationHelper.checkValidation(
                        first: controller.reserveweight.text.trim(),
                        type: ValidationHelper.name)) {
                      setState(() {});
                      Get.dialog(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [LoaderButton()]));
                      var result =
                          await Get.put(UpdateWDController()).UpdateWdData(
                        reprintcontroller.ReprintModel.value == null
                            ? ''
                            : reprintcontroller
                                .ReprintModel.value.finalPhyWeight
                                .toString(),
                        controller.GetWDModel.value == null
                            ? ''
                            : controller.reserveweight.text.toString(),
                        controller.GetWDModel.value == null
                            ? ''
                            : Config.omid.toString(),
                        controller.GetWDModel.value == null
                            ? ''
                            : controller.imageFile.value.path != ''
                                ? controller.imageFile.value
                                : '',
                        controller.GetWDModel.value == null
                            ? ''
                            : controller.imageFile1.value.path != ''
                                ? controller.imageFile1.value
                                : '',
                        controller.GetWDModel.value == null
                            ? ''
                            : controller.imageFile2.value.path != ''
                                ? controller.imageFile2.value
                                : '',
                      );
                      controller.imageFile.value = File('');

                      controller.imageFile1.value = File('');
                      controller.imageFile2.value = File('');
                      Get.back();
                      if (result['status'] == 'success') {
                        print('route');

                        // Get.offAllNamed(RoutesApp.Hwabpage);
                        // Get.toNamed(
                        //     RoutesApp
                        //         .Hwabpage);
                        // Configg.lastmile =
                        //     '';
                        Get.offAllNamed(RoutesApp.reprintscan);
                        Utils.showMessage(message: result['html_message']);

                        // return Get.snackbar(
                        //   '',
                        //   result[
                        //       'html_message'],
                        //   snackStyle:
                        //       SnackStyle
                        //           .FLOATING,
                        //   snackPosition:
                        //       SnackPosition
                        //           .BOTTOM,
                        //   backgroundColor:
                        //       Color(
                        //           0xff0f1210),
                        //   colorText: Color(
                        //       0xffffffff),
                        //   padding: EdgeInsets
                        //       .symmetric(
                        //     vertical: 2,
                        //   ),
                        // );
                      } else if (result['status'] == 'error') {
                        return Utils.showMessage(
                            message: result['html_message']);

                        // return Get.snackbar(
                        //   '',
                        //   result[
                        //       'html_message'],
                        //   snackPosition:
                        //       SnackPosition
                        //           .BOTTOM,
                        //   backgroundColor:
                        //       Color(
                        //           0xff0f1210),
                        //   colorText: Color(
                        //       0xffffffff),
                        //   padding: EdgeInsets
                        //       .symmetric(
                        //     vertical: 2,
                        //   ),
                        // );
                      } else {
                        return null;
                      }
                    }
                    // {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: const Text('Successfully Submited'),
                    //   ));
                    //   Get.toNamed(RoutesApp.reprintscan);
                    // }
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                        child: Text(
                          Variable.submit,
                          style: bottomescalate,
                        ),
                      ))),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff0052cc)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ))),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
