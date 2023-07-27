import 'package:xborders/core/api/config/config.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/module/hwabscan/controller/baglable_controller.dart';
import 'package:xborders/module/hwabscan/controller/hwabscan_controller.dart';
import 'package:xborders/module/hwabscan/controller/unload_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class hwab extends StatefulWidget {
  String caption1;
  String caption2;
  String id;

  hwab({Key key, this.caption1, this.caption2, this.id}) : super(key: key);

  // const hwab({ Key key }) : super(key: key);

  @override
  _hwabState createState() => _hwabState(caption1, caption2, id);
}

class _hwabState extends State<hwab> {
  String caption1;
  String caption2;
  String id;

  _hwabState(this.caption1, this.caption2, this.id);

  // hwab($, Set<int> set);
  final UnloadController controller = Get.put(UnloadController());
  final BagDetailController bagcontroller = Get.put(BagDetailController());
  final HwabDetailController hwabDetailController =
      Get.put(HwabDetailController());
  var value = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.89,
      child: Card(
          color: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    caption1,
                    style: hwabcard,
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'wt',
                      style: hwabcard,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      caption2,
                      style: hwabcard,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'kg',
                      style: hwabcard,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                      // title: const Text('AlertDialog Title'),
                                      content: const Text(
                                          'Are You Sure You Want To Remove'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Yes');
                                            removeitem(id);
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
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  void removeitem(id) {
    var unloadoutput = Get.put(UnloadController()).unloadData(
      id,
    );

    if (unloadoutput['status' == 'success']) {
      // Get.snackbar(title, message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Deleted Successfully'),
      ));
    }
    Configg.lastmile = '';
    setState(() {});
  }
}
