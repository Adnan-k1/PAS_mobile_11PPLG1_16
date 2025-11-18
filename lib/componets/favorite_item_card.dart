import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../model/store_model.dart';
import 'product_detail_dialog.dart';

class FavoriteItemCard extends StatelessWidget {
  final Storemodel product;

  FavoriteItemCard({super.key, required this.product});

  final StoreController c = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.image, width: 56, fit: BoxFit.contain),
      title: Text(
        product.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),

      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          final confirm = await Get.dialog<bool>(
            AlertDialog(
              title: const Text('Remove favorite'),
              content: const Text('Remove this item from favorites?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );

          if (confirm == true) {
            await c.toggleBookmark(product);
            Get.snackbar(
              'Removed',
              'Removed from favorites',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      ),

      onTap: () => showProductDetailDialog(context, product),
    );
  }
}
