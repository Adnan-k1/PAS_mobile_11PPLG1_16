import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/primary_button.dart';
import '../../controllers/register_controller.dart';

class RegisterApiPage extends StatelessWidget {
  RegisterApiPage({super.key});

  final RegisterController regC = Get.put(RegisterController());

  static const Color primaryBlue = Color(0xFF194AA1);
  static const Color lightBlueLogo = Color(0xFF007BFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

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
                    "Create your Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87),
                  ),
                ),

                const SizedBox(height: 20),

                // FULL NAME
                CustomTextField(
                  controller: regC.fullNameC,
                  hint: "Full Name",
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 12),

                // USERNAME
                CustomTextField(
                  controller: regC.nameC,
                  hint: "Username",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),

                // EMAIL
                CustomTextField(
                  controller: regC.emailC,
                  hint: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 12),

                // PASSWORD (pastikan controller diberikan)
                CustomTextField(
                  controller: regC.passC,
                  hint: "Password",
                  obscure: true,
                ),
                const SizedBox(height: 12),

                // CONFIRM PASSWORD (pastikan controller diberikan)
                CustomTextField(
                  controller: regC.confirmPassC,
                  hint: "Confirm Password",
                  obscure: true,
                ),
                const SizedBox(height: 20),

                // REGISTER BUTTON
                Obx(() => PrimaryButton(
                      text: "Sign Up",
                      isLoading: regC.isLoading.value,
                      onPressed: () => regC.register(),
                    )),

                const SizedBox(height: 25),

                Text(
                  "- Or continue manually -",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      children: const [
                        TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}