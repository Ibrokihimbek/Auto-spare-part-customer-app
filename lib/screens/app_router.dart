import 'package:auto_spare_part/main.dart';
import 'package:auto_spare_part/screens/admin/admin_page.dart';
import 'package:auto_spare_part/screens/admin/category/add_category_page.dart';
import 'package:auto_spare_part/screens/admin/category/show_category_page.dart';
import 'package:auto_spare_part/screens/admin/category/update_category_page.dart';
import 'package:auto_spare_part/screens/admin/product/add_product_page.dart';
import 'package:auto_spare_part/screens/admin/product/show_product.dart';
import 'package:auto_spare_part/screens/admin/product/update_product_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/bottom_navigation_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/cart/cart_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/home/product/product_info/product_info.dart';
import 'package:auto_spare_part/screens/bottom_nav/home/product/product_page.dart';
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
  static const showCategory = 'showCategory';
  static const updateCategory = 'updateCategory';
  static const product = 'product';
  static const showProduct = 'showProduct';
  static const addProduct = 'addProduct';
  static const updateProduct = 'updateProduct';
  static const productInfo = 'productInfo';
  static const cart = 'cart';
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.showCategory:
        return MaterialPageRoute(builder: (_) => ShowCategoryPage());
      case RouteName.productInfo:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ProductInfoPage(
            productModel: args['singleProduct'],
          ),
        );
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
        case RouteName.cart:
        return MaterialPageRoute(builder: (_) => CartPage());
      case RouteName.bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNavPage());
      case RouteName.main:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RouteName.admin:
        return MaterialPageRoute(builder: (_) => AdminPage());
      case RouteName.addCategory:
        return MaterialPageRoute(builder: (_) => AddCategoryPage());
      case RouteName.product:
        return MaterialPageRoute(builder: (_) => ProductPage());
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteName.showProduct:
        return MaterialPageRoute(builder: (_) => ShowProductPage());
      case RouteName.addProduct:
        return MaterialPageRoute(builder: (_) => AddProductPage());
      case RouteName.updateProduct:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => UpdateProductPage(
            productModel: args['productItem'],
          ),
        );
      case RouteName.updateCategory:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => UpdateCategoryPage(
                  categoryModel: args['categoryItem'],
                ));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
