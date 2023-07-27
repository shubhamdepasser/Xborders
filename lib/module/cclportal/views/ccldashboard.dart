import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/module/cclportal/model/cclmodel.dart';
import 'package:xborders/module/cclportal/widget/drawer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CclPortal extends StatelessWidget {
  const CclPortal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                toolbarHeight: 56,
                // leadingWidth: 30,
                iconTheme: IconThemeData(color: Colors.black),
                actions: [
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.83,
                          child: Image.asset('assets/icons/ccl.png')),
                    ],
                  ),
                ])),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                drawer()
              ],
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xfff3f4f6)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Column(
                      children: cclHeading
                          .mapIndexed<Widget>(
                            (index, e) => Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Text(
                                                (index + 1).toString(),
                                                style: IncomingShipments,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Text(
                                              e.name,
                                              style: IncomingShipments,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 23,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Wrap(
                                        runSpacing: 25.0,
                                        spacing: 0.0,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        children: getSelectedItems(
                                          e.name.toString(),
                                          e.subType.toString(),
                                        )
                                            .mapIndexed<Widget>((index_2,
                                                    element) =>
                                                element.subType != "card"
                                                    ? InkWell(
                                                        onTap: () {
                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(
                                                          //       builder:
                                                          //           (context) =>
                                                          //               element
                                                          //                   .routePage),
                                                          // );
                                                          Get.toNamed(
                                                              element.routePage,
                                                              arguments: [
                                                                element
                                                                    .page_title,
                                                                element
                                                                    .scan_type
                                                              ]);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  20, 0, 0, 0),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              border: Border.all(
                                                                  color: Color(
                                                                      0xff4c9aff))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            child: Text(
                                                              element.name,
                                                              style:
                                                                  Outforwarehouse,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.26,
                                                        child: InkWell(
                                                          onTap: () =>
                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder: (context) =>
                                                              //             element
                                                              //                 .routePage)),
                                                              Get.toNamed(
                                                                  element
                                                                      .routePage,
                                                                  arguments: [
                                                                element
                                                                    .page_title,
                                                                element
                                                                    .scan_type
                                                              ]),
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                element.img,
                                                                height: 32,
                                                                width: 32,
                                                              ),
                                                              SizedBox(
                                                                height: 7,
                                                              ),
                                                              Text(
                                                                element.name,
                                                                style:
                                                                    Inwardscandashborad,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ))
                                            .toList(),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList()),
                ],
              ),
            )));
  }
}
