import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../home/homeAdmin.dart';
import '../homeUser/homeUser.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      var box = Hive.box('user');
      bool? Login = box.get('Login');

      if (Login ?? false) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeAdmin()));
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeUser()),
        );
      }

      // Navigator.of(context)
      //     .pushReplacement(MaterialPageRoute(builder: (_) => HomeUser()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Logo.png',
              height: 400,
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
