import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/colors.dart';
import 'presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables (catch error if .env not found)
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    print('Warning: .env file not found, using defaults');
  }
  
  runApp(const MosanaApp());
}

class MosanaApp extends StatelessWidget {
  const MosanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mosana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.pureBlack,
        primaryColor: AppColors.mosanaPurple,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
          decorationColor: Colors.transparent,
        ).copyWith(
          bodyLarge: const TextStyle(decoration: TextDecoration.none, color: AppColors.textPrimary),
          bodyMedium: const TextStyle(decoration: TextDecoration.none, color: AppColors.textPrimary),
          bodySmall: const TextStyle(decoration: TextDecoration.none, color: AppColors.textSecondary),
          labelLarge: const TextStyle(decoration: TextDecoration.none),
          labelMedium: const TextStyle(decoration: TextDecoration.none),
          labelSmall: const TextStyle(decoration: TextDecoration.none),
        ),
        // Remove default Material underlines
        dividerColor: Colors.transparent,
      ),
      home: const SplashScreen(),
    );
  }
}
