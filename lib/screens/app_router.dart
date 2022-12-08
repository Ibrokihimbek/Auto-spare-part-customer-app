import 'package:auto_spare_part/main.dart';
import 'package:auto_spare_part/screens/admin/admin_page.dart';
import 'package:auto_spare_part/screens/admin/category/add_category_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/bottom_navigation_page.dart';
import 'package:auto_spare_part/screens/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'bottom_nav/home/home_page.dart';

abstract class RouteName {
  static const splash = 'splash';
  static const bottomNav = 'bottomNav';
  static const main = 'main';
  static const addCategory = 'addCategory';
  static const admin = 'admin';
  static const home = 'home';
  static const productInfo = 'productInfo';
  static const search = 'search';
  static const checkout = 'checkout';
  static const successPayment = 'successPayment';
  static const profile = 'profile';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case RouteName.bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNavPage());
      case RouteName.main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RouteName.admin:
        return MaterialPageRoute(builder: (_) => AdminPage());
      case RouteName.addCategory:
        return MaterialPageRoute(builder: (_) => AddCategoryPage());
      // case RoutName.checkout:
      //   return MaterialPageRoute(builder: (_) => CheckoutPaage());
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      // case RoutName.profile:
      //   return MaterialPageRoute(builder: (_) => ProfilePage());
      // case RoutName.successPayment:
      //   return MaterialPageRoute(builder: (_) => SuccesPaymentPage());
      // case RoutName.productInfo:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => ProductInfoPage(
      //       productInfo: args['productInfo'],
      //     ),
      //   );
      // case RoutName.search:
      //   return MaterialPageRoute(builder: (_) => SearchPage());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}