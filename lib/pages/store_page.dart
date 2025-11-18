import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../model/store_model.dart';
import '../componets/product_card.dart';
import '../componets/product_detail_dialog.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({super.key});

  final StoreController c = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            icon: const Icon(Icons.favorite),
            onPressed: () => Get.to(() => FavoritesPage()),
          ),
          IconButton(
            tooltip: 'Profile',
            icon: const Icon(Icons.person),
            onPressed: () => Get.to(() => ProfilePage()),
          ),
        ],
      ),

      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (c.error.isNotEmpty) {
          return Center(child: Text(c.error.value));
        }

        final products = c.products;

        if (products.isEmpty) {
          return const Center(child: Text('No products'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.66,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (_, i) {
              final Storemodel p = products[i];
              return ProductCard(
                product: p,
                onDetail: () => showProductDetailDialog(context, p),
              );
            },
          ),
        );
      }),
    );
  }
}
