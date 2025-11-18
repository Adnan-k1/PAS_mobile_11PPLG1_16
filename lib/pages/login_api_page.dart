import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../../controllers/LoginApiController.dart';

class LoginApiPage extends StatelessWidget {
  LoginApiPage({super.key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final LoginApiController loginC = Get.put(LoginApiController());

  static const Color primaryBlue = Color(0xFF194AA1);
  static const Color lightBlueLogo = Color(0xFF007BFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("cigni",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: primaryBlue)),
                  Text("fi",
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: lightBlueLogo)),
                ],
              ),

              const SizedBox(height: 35),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login to your Account",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),

              // EMAIL
              CustomTextField(
                controller: emailC,
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              // PASSWORD
              CustomTextField(
                controller: passwordC,
                hint: "Password",
                obscure: true,
              ),

              const SizedBox(height: 20),

              // LOGIN BUTTON
              Obx(() => PrimaryButton(
                    text: "Sign In",
                    isLoading: loginC.isLoading.value,
                    onPressed: () {
                      if (emailC.text.isEmpty || passwordC.text.isEmpty) {
                        Get.snackbar(
                          "Perhatian",
                          "Mohon isi semua kolom.",
                          backgroundColor: primaryBlue,
                          colorText: Colors.white,
                        );
                      } else {
                        loginC.loginWithApi(
                          emailC.text.trim(),
                          passwordC.text.trim(),
                        );
                      }
                    },
                  )),

              const SizedBox(height: 25),

              Text(
                "- Or continue manually -",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: loginC.SignUp,
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    children: const [
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                              color: primaryBlue,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
