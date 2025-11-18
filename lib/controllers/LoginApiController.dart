import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_service.dart';
import '../model/login_model.dart';

class LoginApiController extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhoto = ''.obs;

  // ================================
  // LOGIN API BIASA
  // ================================
  Future<void> loginWithApi(String username, String password) async {
    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      // Panggil API
      LoginModel response = await ApiService.login(username, password);

      if (response.status) {
        // --------------------------
        // LOGIN BERHASIL
        // --------------------------
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("loginType", "api");
        await prefs.setString("token", response.token ?? "");
        await prefs.setString("name", username);

        userName.value = username;
        userEmail.value = "";
        userPhoto.value = "";

        message.value = "Login API berhasil!";
        Get.snackbar("Berhasil", "Selamat datang $username");

        Get.offAllNamed('/main');
      } else {
        // --------------------------
        // PASSWORD / USERNAME SALAH
        // --------------------------
        message.value = "Login gagal: ${response.message}";

        // Tampilkan notifikasi
        Get.snackbar(
          "Login Gagal",
          response.message == "invalid password"
              ? "Password anda salah!"
              : "Username atau password salah.",
          backgroundColor: const Color.fromARGB(255, 255, 80, 80),
          colorText: const Color.fromARGB(255, 255, 255, 255),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // --------------------------
      // ERROR JARINGAN / SERVER
      // --------------------------
      message.value = "Error API login: $e";

      Get.snackbar(
        "Error",
        "Terjadi kesalahan: $e",
        backgroundColor: const Color.fromARGB(255, 255, 80, 80),
        colorText: const Color.fromARGB(255, 255, 255, 255),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================================
  // LOGOUT
  // ================================
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("isLoggedIn");
    await prefs.remove("loginType");
    await prefs.remove("token");
    await prefs.remove("name");

    userName.value = "";
    userEmail.value = "";
    userPhoto.value = "";

    Get.offAllNamed('/login');
  }

  
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      userName.value = prefs.getString("name") ?? "";
      userEmail.value = prefs.getString("email") ?? "";
      userPhoto.value = prefs.getString("photo") ?? "";

      Get.offAllNamed('/profile');
    } else {
      Get.offAllNamed('/login');
    }
  }

  Future<void> SignUp() async{
    Get.toNamed('/register');
    // Navigasi ke halaman signup
  }

  
  Future<void> loadUserDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    userName.value = prefs.getString("name") ?? "";
    userEmail.value = prefs.getString("email") ?? "";
    userPhoto.value = prefs.getString("photo") ?? "";
  }
}
