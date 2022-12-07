import 'package:auto_spare_part/data/app_repositroy/auth_repository.dart';
import 'package:auto_spare_part/screens/app_router.dart';
import 'package:auto_spare_part/screens/auth/auth_page.dart';
import 'package:auto_spare_part/screens/bottom_nav/bottom_navigation_page.dart';
import 'package:auto_spare_part/view_model/auth_view_model.dart';
import 'package:auto_spare_part/view_model/bottom_nav_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavViewModel()),
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
            return BottomNavPage();
          } else {
            return AuthPage();
          }
        });
  }
}
