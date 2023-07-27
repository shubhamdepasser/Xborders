// import 'package:xborders/module/inwardscan/views/invardscan.dart';
import 'package:xborders/module/auth_user/login.dart';
import 'package:xborders/module/cclportal/views/ccldashboard.dart';
import 'package:xborders/module/hwabscan/views/baglable.dart';
import 'package:xborders/module/hwabscan/views/hwad.dart';
import 'package:xborders/module/inwardscan/views/invardscan.dart';
import 'package:xborders/module/reprintscan/views/reprint_scan.dart';
import 'package:xborders/module/reprintscan/views/reprint_scan_yes.dart';
import 'package:get/get.dart';

class RoutesApp {
  RoutesApp._();
  static String login = '/login';
  static String cclportal = '/cclportal';
  static String invardScreen = '/invardScreen';
  static String reprintscan = '/reprintscan';
  static String reprintyesscan = '/reprintyesscan';
  // hwab
  static String Baglable = '/baglable';
  //static String Hwab = '/hwab';
  static String Hwabpage = '/hwad';

  static final routes = [
    GetPage(
        name: RoutesApp.login,
        page: () => Login(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => Login(), fenix: true))),
    GetPage(
        name: RoutesApp.invardScreen,
        page: () => InwardScan(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => InwardScan(), fenix: true))),
    GetPage(
        name: RoutesApp.reprintscan,
        page: () => ReprintScan(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => ReprintScan(), fenix: true))),
    GetPage(
        name: RoutesApp.reprintyesscan,
        page: () => Reprintyes(),
        binding: BindingsBuilder(
            () => Get.lazyPut(() => Reprintyes(), fenix: true))),
    GetPage(
        name: RoutesApp.cclportal,
        page: () => CclPortal(),
        binding:
            BindingsBuilder(() => Get.lazyPut(() => CclPortal(), fenix: true))),

    // hwab
    GetPage(
        name: RoutesApp.Hwabpage,
        page: () => HwabPage(),
        binding: BindingsBuilder(() => Get.lazyPut(
              () => HwabPage(),
              fenix: true,
            ))),

    GetPage(
        name: RoutesApp.Baglable,
        page: () => baglable(),
        binding: BindingsBuilder(() => Get.lazyPut(
              () => baglable(),
              fenix: true,
            ))),
  ];
}
