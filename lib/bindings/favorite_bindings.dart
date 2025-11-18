
import 'package:get/get.dart';
import '../controllers/favorite_controlller.dart';

class FavoriteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}