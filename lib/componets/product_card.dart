import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../model/store_model.dart';

class ProductCard extends StatelessWidget {
  final Storemodel product;
  final VoidCallback? onDetail;

  ProductCard({super.key, required this.product, this.onDetail});

  final StoreController c = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          // Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.green),
            ),
          ),

          // Bottom Buttons
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              // Favorite button
              Obx(() {
                bool bookmarked = c.isBookmarked(product.id);
                return IconButton(
                  icon: Icon(
                    bookmarked ? Icons.favorite : Icons.favorite_border,
                    color: bookmarked ? Colors.red : null,
                  ),
                  onPressed: () async {
                    await c.toggleBookmark(product);
                    Get.snackbar(
                      bookmarked ? 'Removed' : 'Saved',
                      bookmarked
                          ? 'Removed from favorites'
                          : 'Saved to favorites',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                );
              }),

              // Details button
              TextButton(
                onPressed: onDetail,
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
