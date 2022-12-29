import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/detailpage.dart';
import 'package:notes_app/screens/homepage.dart';
import 'package:notes_app/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "SplashScreen",
      routes: {
        "HomePage": (context) => const HomePage(),
        "DetailPage": (context) => const DetailPage(),
        "SplashScreen": (context) => const SplashScreen(),
      },
    ),
  );
}
