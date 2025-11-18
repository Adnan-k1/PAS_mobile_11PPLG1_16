import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../componets/favorite_item_card.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final StoreController c = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),

      body: Obx(() {
        final favs = c.favoriteProducts;

        if (favs.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: favs.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, i) {
            return FavoriteItemCard(product: favs[i]);
          },
        );
      }),
    );
  }
}
