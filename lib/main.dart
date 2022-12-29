import 'package:authentication_app/screens/HomePage.dart';
import 'package:authentication_app/screens/dashboard.dart';
import 'package:authentication_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splashscreen",
      routes: {
        "HomePage": (context) => const HomePage(),
        "Dashboard": (context) => const DashBoard(),
        "splashscreen": (context) => const splash_screen(),
      },
    ),
  );
}
