import 'package:get/get.dart';
import '../model/store_model.dart';
import '../helper/database_halper.dart';
import 'store_controller.dart';

class FavoriteController extends GetxController {
  final DbService _db = DbService();

  var isLoading = false.obs;
  var bookmarks = <Storemodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    try {
      isLoading.value = true;
      final list = await _db.getBookmarks();
      bookmarks.assignAll(list);
    } catch (e) {
      bookmarks.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeBookmark(int id) async {
    try {
      await _db.deleteBookmark(id);
      bookmarks.removeWhere((p) => p.id == id);
      bookmarks.refresh();
      if (Get.isRegistered<StoreController>()) {
        try {
          final sc = Get.find<StoreController>();
          await sc.loadBookmarks();
        } catch (_) {}
      }
    } catch (e) {
      rethrow;
    }
  }
}