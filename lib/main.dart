import 'package:author_registration/screens/add_book.dart';
import 'package:author_registration/screens/homepage.dart';
import 'package:author_registration/screens/splash_screen.dart';
import 'package:author_registration/screens/update_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "Splash_Screen",
      routes: {
        "HomePage": (context) => HomePage(),
        "Add_Book": (context) => Add_Book(),
        "Update_Book": (context) => Update_Book(),
        "Splash_Screen": (context) => Splash_Screen(),
      },
    ),
  );
}
