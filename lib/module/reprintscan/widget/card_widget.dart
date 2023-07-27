import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/reprintscan/controller/reprint_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ReprintCardwidget extends StatefulWidget {
  final String img;
  final Color color;
  final String word1;
  final String word2;
  final String link;

  const ReprintCardwidget({
    Key key,
    this.img,
    this.color,
    this.word1,
    this.word2,
    this.link,
  }) : super(key: key);

  @override
  State<ReprintCardwidget> createState() => _ReprintCardwidgetState();
}

class _ReprintCardwidgetState extends State<ReprintCardwidget> {
  String word = '';
  final reprintDetailController reprintscanDetailController =
      Get.put(reprintDetailController());

  void didChangeDependencies() async {
    super.didChangeDependencies();
    var output = await reprintscanDetailController.ReprintData(Config.awb);
    if (output['document_2_status'].toString() == '0'.toString()) {
      print("1t656576t");
      word = 'Pending';
    } else {
      word = 'Approved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    borderRadius: BorderRadius.circular(8),
                    color: widget.color),
                child: Image.asset(
                  widget.img,
                  height: 25,
                  width: 25,
                )),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      widget.word1,
                      style: phonenumberstyle,
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Text(
                      widget.word2,
                      style: pending,
                    )),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 78.0),
          child: ElevatedButton(
              onPressed: () {
                widget.link;
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ))),
        ),
      ],
    );
  }
}

class ReprintCardinvoicewidget extends StatefulWidget {
  final String img;
  final Color color;
  final String word1;

  ReprintCardinvoicewidget({
    Key key,
    this.img,
    this.color,
    this.word1,
  }) : super(key: key);

  @override
  State<ReprintCardinvoicewidget> createState() =>
      _ReprintCardinvoicewidgetState();
}

class _ReprintCardinvoicewidgetState extends State<ReprintCardinvoicewidget> {
  dynamic word = 'abc';
  final reprintDetailController reprintscanDetailController =
      Get.put(reprintDetailController());

  void didChangeDependencies() async {
    super.didChangeDependencies();
    var output = await reprintscanDetailController.ReprintData(Config.awb);

    print(Config.awb);
    if (output['document_1_status'].toString() == '0'.toString()) {
      print("1t656576t");
      word = 'Pending';
    } else {
      word = 'Approved';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    borderRadius: BorderRadius.circular(8),
                    color: widget.color),
                child: Image.asset(
                  widget.img,
                  height: 25,
                  width: 25,
                )),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      widget.word1,
                      style: phonenumberstyle,
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Text(word, style: InterHeading)),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 78.0),
          child: ElevatedButton(
              onPressed: () async {},
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff36b27e)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ))),
        ),
      ],
    );
  }
}
