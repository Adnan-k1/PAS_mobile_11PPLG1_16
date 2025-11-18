import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/LoginApiController.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final LoginApiController controller = Get.find<LoginApiController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        centerTitle: true,
       
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => controller.signOut(),
          ),
        ],
      ),

      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),

              
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: controller.userPhoto.value.isNotEmpty
                      ? NetworkImage(controller.userPhoto.value)
                      : null,
                  child: controller.userPhoto.value.isEmpty
                      ? Icon(Icons.person,
                          size: 55, color: Colors.grey.shade700)
                      : null,
                ),
              ),

              const SizedBox(height: 15),

             
              Text(
                controller.userName.value.isNotEmpty
                    ? controller.userName.value
                    : "No Name",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              
              Text(
                controller.userEmail.value.isNotEmpty
                    ? controller.userEmail.value
                    : "No Email",
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue.shade700),
                          const SizedBox(width: 10),
                          const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.userName.value.isNotEmpty
                            ? controller.userName.value
                            : "Not Set",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),

                      const Divider(height: 30),

                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.blue.shade700),
                          const SizedBox(width: 10),
                          const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.userEmail.value.isNotEmpty
                            ? controller.userEmail.value
                            : "Not Set",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
