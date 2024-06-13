
// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:plantify_app/ImagePickerDemo.dart';
import 'package:plantify_app/Result.dart';
import 'package:plantify_app/home.dart';
import 'package:plantify_app/login.dart';

// import 'package:trafproj/result.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen.gif(
          gifPath: 'assets/plantifyLogo-removebg-preview.png',
          gifWidth: 269,
          gifHeight: 474,
          backgroundColor:Colors.white,
          nextScreen: const LoginScreen(),
          duration: const Duration(milliseconds: 3515),
          onInit: () async {
            debugPrint("onInit");
          },
          onEnd: () async {
            debugPrint("onEnd 1");
          },
        ),
       routes: {
        // ignore: prefer_const_constructors
        '/login':(context) => LoginScreen(),
        '/home': (context) => home(),
        '/test': (context) => ImagePickerDemo(),
        '/result': (context) => Result(),
      },
    );
  }
}
