// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:plantify_app/home.dart';


const users =  {
  'abdelrahman@gmail.com': '12345',
  'hassan@gmail.com': '1234',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
  
     debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null!;
    });
  
}
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo:AssetImage('assets/plantifyLogo-removebg-preview.png'),
      theme: LoginTheme(
        primaryColor:Color.fromARGB(255, 66, 126, 59),
       ),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamed(context, '/home');
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}