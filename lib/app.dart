import 'package:flash_card/screens/study_screen.dart';
import 'package:flash_card/screens/voca_screen.dart';
import 'package:flash_card/screens/word_list.screen.dart';
import 'package:flash_card/screens/word_screen.dart';
import 'package:flash_card/widgets/study_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flash_card/screens/login_screen.dart';
import 'package:flash_card/screens/register_screen.dart';
import 'package:flash_card/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      title: 'Memory Word',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      initialRoute: '/voca',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/voca', page: () => const VocaScreen()),
        GetPage(name: '/word', page: () => const WordScreen()),
        GetPage(name: '/wordList', page: () => const WordListScreen()),
        GetPage(name: '/study', page: () => const StudyScreen()),
      ],
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      scaffoldBackgroundColor: Colors.grey[100],
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true, 
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}