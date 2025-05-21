import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urovo/services/pref_service.dart';
import 'package:urovo/view/auth/login.dart';
import 'package:urovo/view/auth/splash_screen.dart';
import 'package:urovo/view/home/home.dart';

import 'utils/app_routes.dart';
import 'view/home/bottombar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Creative Ease',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromRGBO(16, 16, 16, 1),
        //    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      getPages: AppPage.list,
      // initialRoute: "/",
    );
  }
}
