import 'package:get/get.dart';
import '../pages/login_api_page.dart';
import '../bindings/login_api_bindings.dart';
import '../pages/SplashScreen.dart';
import '../bindings/splash_binding.dart';
import '../bindings/main_bindings.dart';
import '../pages/main_page.dart';
import '../bindings/register_bindings.dart';
import '../pages/register_api_page.dart';
import '../bindings/store_bindings.dart';
import '../pages/store_page.dart';
import '../bindings/favorite_bindings.dart';
import '../pages/favorite_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginApiPage(),
      binding: LoginApiBinding(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/main',
      page: () => MainMenuPage(),
      binding: MainBindings(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterApiPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/store',
      page: () => ProductListPage(),
      binding: StoreBindings(),
    ),
    GetPage(
      name: '/favorites',
      page: () => FavoritesPage(),
      binding: FavoriteBindings(),
    ),


    
    // Add other routes here
  ];
}