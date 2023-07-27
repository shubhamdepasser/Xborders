import 'package:xborders/core/routes/app_routes.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:xborders/module/hwabscan/views/hwad.dart';
import 'package:xborders/module/inwardscan/views/invardscan.dart';
import 'package:xborders/module/inwardscan/widget/inwardscan_card.dart';
import 'package:xborders/module/reprintscan/views/reprint_scan.dart';

class CclList {
  String name;
  String img;
  String type;
  dynamic routePage;
  String page_title;
  String scan_type;
  String subType;

  CclList({
    this.name,
    this.img,
    this.type,
    this.routePage,
    this.page_title,
    this.scan_type,
    this.subType,
  });
}

List<CclList> getSelectedItems(String type, String sub_type) {
  if (type != "") {
    if (cclList.any((element) => element.type == type)) {
      return cclList.where((element) => element.type == type).toList();
    } else {
      return [];
    }
  } else {
    if (cclList.any((element) => element.name == sub_type)) {
      return cclList.where((element) => element.name == sub_type).toList();
    } else {
      return [];
    }
  }
}

List<CclList> cclList = [
  CclList(
    name: Variable.inwardscan,
    type: Variable.incommingshipments,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.inwardscan,
    scan_type: "1",
    subType: "card",
    img: AppIconImage.Inwardscan,
  ),
  CclList(
    name: Variable.reprintscan,
    type: Variable.incommingshipments,
    routePage: RoutesApp.reprintscan,
    page_title: Variable.inwardscan,
    scan_type: "1",
    subType: "card",
    img: AppIconImage.reprintImage,
  ),
  CclList(
    name: Variable.createbag,
    type: Variable.bagging,
    routePage: RoutesApp.Hwabpage,
    page_title: Variable.inwardscan,
    scan_type: "1",
    subType: "card",
    img: AppIconImage.CreateBag,
  ),
  CclList(
    name: Variable.outfromwarehouse,
    type: "",
    subType: "button",
    routePage: RoutesApp.invardScreen,
    page_title: Variable.outfromwarehouse,
    scan_type: "6",
    img: AppIconImage.invardscanImage,
  ),
  CclList(
    name: Variable.Approve,
    type: Variable.Xrayscan,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.xrayrejectapproved,
    scan_type: "7",
    subType: "card",
    img: AppIconImage.Approve,
  ),
  CclList(
    name: Variable.Hold,
    type: Variable.Xrayscan,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.xrayhold,
    scan_type: "19",
    subType: "card",
    img: AppIconImage.Hold,
  ),
  CclList(
    name: Variable.reject,
    type: Variable.Xrayscan,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.xrayreject,
    scan_type: "8",
    subType: "card",
    img: AppIconImage.Reject,
  ),
  CclList(
    name: Variable.Approve,
    type: Variable.customclearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.customclearenceApproved,
    scan_type: "9",
    subType: "card",
    img: AppIconImage.Approve,
  ),
  CclList(
    name: Variable.Hold,
    type: Variable.customclearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.customclearencehold,
    scan_type: "20",
    subType: "card",
    img: AppIconImage.Hold,
  ),
  CclList(
    name: Variable.reject,
    type: Variable.customclearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.customclearencereject,
    scan_type: "10",
    subType: "card",
    img: AppIconImage.Reject,
  ),
  CclList(
    name: Variable.Approve,
    type: Variable.SecurityClearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.SecurityClearenceapproved,
    scan_type: "21",
    subType: "card",
    img: AppIconImage.Approve,
  ),
  CclList(
    name: Variable.Hold,
    type: Variable.SecurityClearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.SecurityClearencehold,
    scan_type: "23",
    subType: "card",
    img: AppIconImage.Hold,
  ),
  CclList(
    name: Variable.reject,
    type: Variable.SecurityClearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.SecurityClearencereject,
    scan_type: "22",
    subType: "card",
    img: AppIconImage.Reject,
  ),
  CclList(
    name: Variable.movetocage,
    type: Variable.SecurityClearence,
    routePage: RoutesApp.invardScreen,
    page_title: Variable.movetocage,
    scan_type: "14",
    subType: "card",
    img: AppIconImage.Movietocage,
  ),
  CclList(
    name: Variable.airlift,
    type: "",
    subType: "button",
    routePage: RoutesApp.invardScreen,
    page_title: Variable.airlift,
    scan_type: "11",
    img: AppIconImage.invardscanImage,
  ),
];

class CclHeadList {
  String name;
  String subType;

  CclHeadList({
    this.name,
    this.subType,
  });
}

List<CclHeadList> cclHeading = [
  CclHeadList(
    name: Variable.incommingshipments,
    subType: Variable.incommingshipments,
  ),
  CclHeadList(
    name: Variable.bagging,
    subType: Variable.bagging,
  ),
  CclHeadList(
    name: "",
    subType: Variable.outfromwarehouse,
  ),
  CclHeadList(
    name: Variable.Xrayscan,
    subType: Variable.Xrayscan,
  ),
  CclHeadList(
    name: Variable.customclearence,
    subType: Variable.customclearence,
  ),
  CclHeadList(
    name: Variable.SecurityClearence,
    subType: Variable.SecurityClearence,
  ),
  CclHeadList(
    name: "",
    subType: Variable.airlift,
  ),
];
