import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_do/provider/tab_controller_provider.dart';
import 'package:swift_do/provider/todo_provider.dart';
import 'package:swift_do/screens/home_screen/screen/home_screen.dart';
import 'package:swift_do/screens/splash_screen/screen/splash_screen.dart';
import 'package:swift_do/utils/color_constants.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => TabControllerProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwiftDo',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: surfaceColor,
        appBarTheme: AppBarTheme(
          backgroundColor: surfaceColor,
          foregroundColor: onSurfaceColor,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: onSurfaceColor),
          bodySmall: TextStyle(color: onSurfaceColor),
          bodyMedium: TextStyle(color: onSurfaceColor),
    
        ),
      ),
      home: SplashScreen(nextScreen: HomeScreen(),),
    );
  }
}
