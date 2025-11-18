import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg1_16/routes/roters.dart';
import 'LoginApiController.dart';

final loginController = Get.find<LoginApiController>();

class ProfileController extends GetxController {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // hapus semua data login
    await loginController.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
