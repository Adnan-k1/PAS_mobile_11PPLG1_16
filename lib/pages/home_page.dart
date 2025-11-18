import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("Selamat Datang, ${controller.userEmail}")),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      body: Center(
        child: Obx(() => Text(
          "Halo ${controller.userEmail} 👋",
          style: const TextStyle(fontSize: 22),
        )),
      ),
    );
  }
}
