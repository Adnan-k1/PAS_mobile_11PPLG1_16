import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg1_16/routes/roters.dart';
import 'LoginApiController.dart';

class SplashController extends GetxController {
  // Pastikan LoginApiController sudah di-inject di main
  final LoginApiController loginController = Get.find<LoginApiController>();

  @override
  void onReady() {
    super.onReady();
    checkLogin();
  }

  Future<void> checkLogin() async {
    print("SplashController: checkLogin running");
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
      final loginType = prefs.getString("loginType") ?? "";
      final token = prefs.getString("token") ?? "";

      print("isLoggedIn: $isLoggedIn, loginType: $loginType, token: $token");

      await Future.delayed(const Duration(seconds: 2));

      if (!isLoggedIn || loginType != "api" || token.isEmpty) {
        print("Navigating to LOGIN");
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      print("Login valid, load user data");
      await loginController.loadUserDataFromPrefs();
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      print("Error Splashscreen: $e");
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
