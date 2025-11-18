import 'package:get/get.dart';
import '../controllers/SplashController.dart';

class SplashBinding extends Bindings {  
  @override  
  void dependencies() {  
    Get.lazyPut<SplashController>(() => SplashController());  
  }  
}