import 'package:auto_spare_part/data/app_repositroy/auth_repository.dart';
import 'package:auto_spare_part/data/app_repositroy/categories_repository.dart';
import 'package:auto_spare_part/data/app_repositroy/order_repository.dart';
import 'package:auto_spare_part/data/app_repositroy/products_repository.dart';
import 'package:auto_spare_part/screens/admin_or_home/admin_or_home.dart';
import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/screens/auth/auth_page.dart';
import 'package:auto_spare_part/view_model/auth_view_model.dart';
import 'package:auto_spare_part/view_model/bottom_nav_view_model.dart';
import 'package:auto_spare_part/view_model/category_view_model.dart';
import 'package:auto_spare_part/view_model/order_view_model.dart';
import 'package:auto_spare_part/view_model/product_view_model.dart';
import 'package:auto_spare_part/view_model/profile_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'data/app_repositroy/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavViewModel()),
        ChangeNotifierProvider(
          create: (context) => CategoryViewModel(
            categoryRepository:
                CategoryRepository(firebaseFirestore: fireStore),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(
            productRepository: ProductRepository(firebaseFirestore: fireStore),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersViewModel(
            ordersRepository: OrdersRepository(
              firebaseFirestore: fireStore,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewModel(
            firebaseAuth: FirebaseAuth.instance,
            profileRepository: ProfileRepository(firebaseFirestore: fireStore)
          ),
        ),
        Provider(
          create: (context) => AuthViewModel(
            authRepository: AuthRepository(firebaseAuth: FirebaseAuth.instance),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          initialRoute: RouteName.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Auto Spare Part',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return AdminOrHomePage();
          } else {
            return AuthPage();
          }
        });
  }
}
