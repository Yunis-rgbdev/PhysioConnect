import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/authentication_view.dart';
import 'package:frontend/dashboard_page/dashboard_view.dart';
import 'package:frontend/home_page/home_view.dart';
import 'package:frontend/information_page/information_view.dart';
import 'package:frontend/welcome_page/welcome_view.dart';
import 'package:get/get.dart';

import 'login_page/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0066FF),
        scaffoldBackgroundColor: const Color(0xFF0066FF),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size(400, 45),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.black),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size(400, 45),
            textStyle: const TextStyle(
              fontSize: 16,
              
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginView(),
        '/signup': (context) => AuthView(),
      },
      // home: WelcomeScreen(),
    );
  }
}
