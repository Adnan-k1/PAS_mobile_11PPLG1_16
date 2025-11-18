

import 'package:get/get.dart';
import '../controllers/store_controller.dart';

class StoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(() => StoreController());
  }
}