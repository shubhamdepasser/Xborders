import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/reprintscan/controller/GetWDdetails_controller.dart';
import 'package:xborders/module/reprintscan/controller/reprint_controller.dart';
import 'package:xborders/module/reprintscan/widget/bottomsheet.dart';
import 'package:xborders/module/reprintscan/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class DamegeNo extends StatefulWidget {
  const DamegeNo({Key key}) : super(key: key);

  @override
  State<DamegeNo> createState() => _DamegeNoState();
}

class _DamegeNoState extends State<DamegeNo> {
  var word2;
  final reprintDetailController reprintscanDetailController =
      Get.put(reprintDetailController());

  void didChangeDependencies() async {
    super.didChangeDependencies();
    reprintscanDetailController.ReprintData(Config.awb);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      Variable.paperwork,
                      style: phonenumberstyle,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  ReprintCardinvoicewidget(
                    img: 'assets/icons/invoice.png',
                    color: Color(0xffeae6ff),
                    word1: 'Invoice',
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ReprintCardwidget(
                    img: 'assets/icons/gst.png',
                    color: Color(0xffe5fcff),
                    word1: 'GST',
                    // word2: 'Approved',
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ReprintCardwidget(
                    img: 'assets/icons/iec.png',
                    color: Color(0xffe3fcef),
                    word1: 'IEC',
                    // word2: 'Pending',
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  ReprintCardwidget(
                    img: 'assets/icons/iec.png',
                    color: Color(0xffe3fcef),
                    word1: 'Letter of Undertaking',
                    // word2: 'Pending',
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                        ),
                        child: ImageItlscanner(
                          image: AppIconImage.weight,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 18,
                                  top: 18,
                                ),
                                child: Text(
                                  Variable.weightmismatch,
                                  style: weight,
                                )),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                    ),
                                    child: Text(
                                      Variable.weight,
                                      style: InterHeading,
                                    )),
                              ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                ),
                                child: Obx(() => Text(
                                    reprintscanDetailController
                                                .ReprintModel.value ==
                                            null
                                        ? ''
                                        : reprintscanDetailController
                                            .ReprintModel.value.finalPhyWeight
                                            .toString(),
                                    style: InterHeading)),
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
                                      left: 18,
                                    ),
                                    child: Text(
                                      Variable.vol,
                                      style: InterHeading,
                                    )),
                              ),
                              Container(
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 3,
                                ),
                                child: Obx(() => Text(
                                    reprintscanDetailController
                                                .ReprintModel.value ==
                                            null
                                        ? ''
                                        : reprintscanDetailController
                                            .ReprintModel.value.volWeight
                                            .toString(),
                                    style: InterHeading)),
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
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff36b27e),
                          ),
                          height: 32,
                          width: 88,
                          child: InkWell(
                            onTap: () async {
                              await Get.put(GetWDDetailController())
                                  .GetWDData('2');
                              await showSlidingBottomSheet(context,
                                  builder: (context) => SlidingSheetDialog(
                                      cornerRadius: 16,
                                      snapSpec: SnapSpec(
                                        snappings: [1, 1],
                                      ),
                                      builder: buildSheet));
                            },
                            child: Text(
                              Variable.escalate,
                              style: InterSmall,
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

          /////////
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: 90,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 17),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                    decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.only(left: 15, top: 18, bottom: 18),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    borderSide:
                        BorderSide(color: Color(0xffd1d5db), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    borderSide:
                        BorderSide(color: Color(0xffd1d5db), width: 1.5),
                  ),
                  hintText: 'Enter Remark',
                  hintStyle: hintstyle,
                  filled: true,
                  fillColor: Color(0xffffffff),
                )),
              ),
            ),
          ),

          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 18.0, bottom: 18),
                    child: Text(Variable.printandsave),
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
    );
  }
}

Widget buildSheet(context, State) => Material(
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Bottomsheet()
        ],
      ),
    );
