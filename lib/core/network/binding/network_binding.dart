import 'package:xborders/core/network/binding/controller/network_controller.dart';
import 'package:get/get.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController(), fenix: true);
  }
}
