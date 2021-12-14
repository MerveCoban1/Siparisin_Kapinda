// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:siparisin_kapinda/views/home.dart';
import 'views/login_screen.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  globals.OnStart();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siparişin Kapında ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: globals.loggedUserId == 0 ? LoginScreen() : Home(),
    );
  }
}


