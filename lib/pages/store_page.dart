// ...existing code...
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/store_controller.dart';
import '../model/store_model.dart';
import 'favorite_page.dart';
import 'profile_page.dart';

class ProductListPage extends StatelessWidget {
  ProductListPage({Key? key}) : super(key: key);

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
        if (c.isLoading.value)
          return const Center(child: CircularProgressIndicator());
        if (c.error.isNotEmpty) return Center(child: Text(c.error.value));
        final products = c.products;
        if (products.isEmpty) return const Center(child: Text('No products'));
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
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(p.image, fit: BoxFit.contain),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4,
                      ),
                      child: Text(
                        '\$${p.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          final bookmarked = c.isBookmarked(p.id);
                          return IconButton(
                            icon: Icon(
                              bookmarked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: bookmarked ? Colors.red : null,
                            ),
                            onPressed: () async {
                              await c.toggleBookmark(p);
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
                        TextButton(
                          child: const Text('Details'),
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: Text(p.title),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(p.image, height: 150),
                                      const SizedBox(height: 8),
                                      Text(p.description),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Rating: ${p.rating.rate} (${p.rating.count})',
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
