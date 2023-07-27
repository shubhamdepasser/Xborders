import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/validation/utils.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/inwardscan/views/invardscan.dart';
import 'package:xborders/module/reprintscan/views/reprint_scan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

import 'package:page_transition/page_transition.dart';

class drawer extends StatelessWidget {
  const drawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      Variable.menu,
                      style: menuStyle,
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),

          Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: ImageItlscanner(
                    image: AppIconImage.ArrowDownImage,
                  )),
              title: Text(
                Variable.incommingshipments,
                style: inwardstyle,
              ),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => InwardScan()),
                        //);
                        Get.toNamed(RoutesApp.invardScreen,
                            arguments: [Variable.inwardscan, "1"]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.inwardscan,
                          style: inwardstyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReprintScan()),
                    );
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 60),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Text(
                        Variable.reprintscan,
                        style: inwardstyle,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            child: Theme(
              data: ThemeData(dividerColor: Colors.transparent),
              child: ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                leading: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: ImageItlscanner(
                      image: AppIconImage.BusImage,
                    )),
                title: Text(
                  Variable.bagging,
                  style: inwardstyle,
                ),
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RoutesApp.Hwabpage),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text(
                            Variable.createbag,
                            style: inwardstyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              Get.toNamed(RoutesApp.invardScreen,
                  arguments: [Variable.outfromwarehouse, "6"]);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => OutforwarhouseScan()),
              // );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: ImageItlscanner(
                          image: AppIconImage.postbag,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          child: Text(Variable.outfromwarehouse,
                              style: inwardstyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: ImageItlscanner(
                    image: AppIconImage.postbag,
                  )),
              title: Text(
                Variable.xrayreject,
                style: inwardstyle,
              ),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.xrayrejectapproved, "7"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => XrayScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Approve,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.xrayhold, "19"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => XrayholdScan()),
                    //);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Hold,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.xrayreject, "8"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => XrayrejectScan()),
                    //);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Reject,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: ImageItlscanner(
                    image: AppIconImage.postbag,
                  )),
              title: Text(
                Variable.customclearence,
                style: inwardstyle,
              ),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.customclearenceApproved, "9"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CustomCleranceScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Approve,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.customclearencehold, "20"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CustomclearenceholdScan()),
                    //);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Hold,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.customclearencereject, "10"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => CustomClerancerejectScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Reject,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: ImageItlscanner(
                    image: AppIconImage.postbag,
                  )),
              title: Text(
                Variable.SecurityClearence,
                style: inwardstyle,
              ),
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.SecurityClearenceapproved, "21"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SecurityapprovedScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Approve,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.SecurityClearencehold, "23"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SecurityholdScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Hold,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RoutesApp.invardScreen,
                        arguments: [Variable.SecurityClearencereject, "22"]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SecurityrejectScan()),
                    // );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          Variable.Reject,
                          style: inwardstyle,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(RoutesApp.invardScreen,
                      arguments: [Variable.airlift, "11"]);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AirliftScan()),
                  // );
                },
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: ImageItlscanner(
                          image: AppIconImage.postbag,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 15),
                          child: Text(Variable.AirliftBag, style: inwardstyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 62),
            child: Divider(
              color: Color(0xffe5e7eb),
              thickness: 1,
            ),
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Image.asset('assets/icons/bus.png'),
          //     Container(
          //       padding: EdgeInsets.only(left: 15),
          //       child: Text(
          //         Variable.dispatch,
          //         style: inwardstyle,
          //       ),
          //     ),
          //     Container(
          //         padding: EdgeInsets.only(left: 156),
          //         child: Image.asset('assets/icons/forward_arrow.png')),
          //   ],
          // ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: InkWell(
              onTap: () {
                _resetAndOpenPage();
                Utils.showMessage(message: 'Loged Out Successfully!!!');
                // Get.toNamed(RoutesApp.login);
              },
              child: Container(
                  child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      Variable.logout,
                      style: inwardstyle,
                    ),
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

void _resetAndOpenPage() {
  // BuildContext context;
  GetStorage storage = GetStorage();
  Get.offAllNamed(RoutesApp.login);
  // ScaffoldMessenger.of(context)
  //     .showSnackBar(SnackBar(content: const Text('Loged Out Successfully!!!')));
  storage.erase();
  //  Get.toNamed(RoutesApp.login);
}
