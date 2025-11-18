import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../network/register_service.dart';
import '../model/register_model.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  final fullNameC = TextEditingController();
  final nameC = TextEditingController();   
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();

  Future<void> register() async {
    final full = fullNameC.text.trim();
    final username = nameC.text.trim();
    final email = emailC.text.trim();
    final pass = passC.text;
    final confirm = confirmPassC.text;

    
    debugPrint("FULL: $full | USERNAME: $username | EMAIL: $email");

    if (full.isEmpty || username.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      Get.snackbar("Error", "Semua field harus diisi");
      return;
    }

    if (pass != confirm) {
      Get.snackbar("Error", "Password tidak sama");
      return;
    }

    try {
      isLoading.value = true;

      Registermodel res = await ApiService.register(
        full,
        username,  
        email,
        pass,
      );

      Get.snackbar(
        res.status ? "Success" : "Failed",
        res.message,
        backgroundColor: res.status ? Colors.green : Colors.red,
        colorText: Colors.white,
      );

      if (res.status) {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed('/login');
        });
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameC.dispose();
    nameC.dispose();
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.onClose();
  }
}
