import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/home_screen_new.dart';
import 'screens/ui_material_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/upload_task_screen.dart';
import 'screens/video_player_screen.dart';
import 'screens/quiz_review_screen.dart';
import 'screens/quiz_question_screen.dart';
import 'screens/quiz_result_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App colors
  static const Color primaryColor = Color(0xFFB91C1C); // Dark Red matching the login design
  static const Color splashPrimaryColor = Color(0xFFB94B4B); // Reddish-brown for splash
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CeLoe LMS',
      debugShowCheckedModeBanner: false,
      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light, // Use light mode by default (matching the new HTML)
      // Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/home_new': (context) => const HomeScreenNew(),
        '/ui_material': (context) => const UIMaterialScreen(),
        '/task_detail': (context) => const TaskDetailScreen(),
        '/upload_task': (context) => const UploadTaskScreen(),
        '/video_player': (context) => const VideoPlayerScreen(),
        '/quiz_review': (context) => const QuizReviewScreen(),
        '/quiz_question': (context) => const QuizQuestionScreen(),
        '/quiz_result': (context) => const QuizResultScreen(),
      },
    );
  }
}
