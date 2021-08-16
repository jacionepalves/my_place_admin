import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_place_admin/core/theme.dart';
import 'package:my_place_admin/pages/sign_in_page.dart';
import 'core/theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SignInPage(),
    );
  }
}
