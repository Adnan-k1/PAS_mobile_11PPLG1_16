

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'home_page.dart';
import 'store_page.dart';
import 'favorite_page.dart';
import 'profile_page.dart';



class MainMenuPage extends StatelessWidget {
  MainMenuPage({super.key});

  
  final MainPageController mainController = Get.find<MainPageController>();

  final List<Widget> pages = [
    HomePage(),
    ProductListPage(),
    FavoritesPage(),
    ProfilePage(),

   
  ];

  final List<String> titles = const [
    "Home", 
    "Store",
    "Profile",
    "Favorites",
    

  ];

 
  final List<Map<String, dynamic>> drawerItems = const [
    {'title': 'Home', 'icon': Icons.home_outlined},
    {'title': 'Store', 'icon': Icons.store_outlined},
    {'title': 'Favorites', 'icon': Icons.favorite_border},
    {'title': 'Profile', 'icon': Icons.person_outline},
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   
        title: Obx(() => Text(
              titles[mainController.selectedIndex.value],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
        backgroundColor: Colors.blue.shade700, 
        foregroundColor: Colors.white,
        elevation: 1.0, 
      ),
      drawer: Drawer(
        child: Column( 
          children: [
       
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 40, bottom: 20, left: 16, right: 16),
              decoration: BoxDecoration(color: Colors.blue.shade700),
              child: const SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.sports_soccer_outlined, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      "App Navigation", // Judul yang lebih deskriptif
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: drawerItems.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => ListTile(
                      leading: Icon(
                        drawerItems[index]['icon'] as IconData?,
                        color: mainController.selectedIndex.value == index
                            ? Colors.blue.shade700
                            : Colors.grey.shade600,
                      ),
                      title: Text(
                        drawerItems[index]['title'] as String,
                        style: TextStyle(
                          fontWeight: mainController.selectedIndex.value == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: mainController.selectedIndex.value == index,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      onTap: () {
                        mainController.changePage(index);
                        Get.back(); 
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: mainController.selectedIndex.value,
          children: pages,
        ),
      ),
    );
  }
}

