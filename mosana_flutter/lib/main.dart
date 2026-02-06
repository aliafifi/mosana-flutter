import 'package:flutter/material.dart';
import 'core/config/colors.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const MosanaApp());
}

class MosanaApp extends StatelessWidget {
  const MosanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.pureBlack,
        primaryColor: AppColors.mosanaPurple,
      ),
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}
