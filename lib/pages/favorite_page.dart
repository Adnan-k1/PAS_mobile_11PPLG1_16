
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../model/store_model.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final StoreController c = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        final favs = c.favoriteProducts;
        if (favs.isEmpty) return const Center(child: Text('No favorites yet'));
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: favs.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (_, i) {
            final Storemodel p = favs[i];
            return ListTile(
              leading: Image.network(p.image, width: 56, fit: BoxFit.contain),
              title: Text(p.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final confirm = await Get.dialog<bool>(AlertDialog(
                    title: const Text('Remove favorite'),
                    content: const Text('Remove this item from favorites?'),
                    actions: [
                      TextButton(onPressed: () => Get.back(result: false), child: const Text('No')),
                      TextButton(onPressed: () => Get.back(result: true), child: const Text('Yes')),
                    ],
                  ));
                  if (confirm == true) {
                    await c.toggleBookmark(p); 
                    Get.snackbar('Removed', 'Removed from favorites', snackPosition: SnackPosition.BOTTOM);
                  }
                },
              ),
              onTap: () {
                Get.dialog(AlertDialog(
                  title: Text(p.title),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(p.image, height: 150),
                        const SizedBox(height: 8),
                        Text(p.description),
                        const SizedBox(height: 8),
                        Text('Rating: ${p.rating.rate} (${p.rating.count})'),
                      ],
                    ),
                  ),
                  actions: [TextButton(onPressed: () => Get.back(), child: const Text('Close'))],
                ));
              },
            );
          },
        );
      }),
    );
  }
}
