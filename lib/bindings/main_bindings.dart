import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../controllers/profil_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/store_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<StoreController>(() => StoreController());
  }
}