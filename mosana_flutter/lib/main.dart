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
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.pureBlack,
        primaryColor: AppColors.mosanaPurple,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(decoration: TextDecoration.none),
          bodyMedium: TextStyle(decoration: TextDecoration.none),
          bodySmall: TextStyle(decoration: TextDecoration.none),
        ),
        // Remove underlines from all text
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: AppColors.mosanaPurple,
        ),
      ),
      home: const SplashScreen(), // Start with Splash Screen
    );
  }
}
