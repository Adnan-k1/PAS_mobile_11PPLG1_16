// ...existing code...
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/store_model.dart';

class StoreController extends GetxController {
  var isLoading = false.obs;
  var error = ''.obs;
  var products = <Storemodel>[].obs;

  final RxSet<int> _bookmarkedIds = <int>{}.obs;

  // Reactive list of bookmarked products for Favorites page
  var favoritedProducts = <Storemodel>[].obs;

  static const String _kBookmarksKey = 'bookmarked_products';

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      error.value = '';
      final uri = Uri.parse('https://fakestoreapi.com/products');
      final resp = await http.get(uri);

      if (resp.statusCode == 200) {
        final list = storemodelFromJson(resp.body);
        products.assignAll(list);
        _syncFavoritedProducts(); // sinkron setelah produk dimuat
      } else {
        error.value = 'Failed to load products. Status: ${resp.statusCode}';
      }
    } catch (e) {
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // sync reactive list based on bookmarked ids
  void _syncFavoritedProducts() {
    favoritedProducts
      ..clear()
      ..addAll(products.where((p) => _bookmarkedIds.contains(p.id)).toList());
    favoritedProducts.refresh();
  }

  bool isBookmarked(int id) => _bookmarkedIds.contains(id);

  List<Storemodel> get favoriteProducts => favoritedProducts;

  Future<void> toggleBookmark(Storemodel product) async {
    if (_bookmarkedIds.contains(product.id)) {
      _bookmarkedIds.remove(product.id);
    } else {
      _bookmarkedIds.add(product.id);
    }

    _bookmarkedIds.refresh();
    await _saveBookmarks();
    _syncFavoritedProducts();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kBookmarksKey) ?? <String>[];
    _bookmarkedIds
      ..clear()
      ..addAll(list.map((s) => int.tryParse(s)).whereType<int>());
    _bookmarkedIds.refresh();
    _syncFavoritedProducts();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _bookmarkedIds.map((i) => i.toString()).toList();
    await prefs.setStringList(_kBookmarksKey, list);
  }
}
