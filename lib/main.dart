import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:flutter_app3/login_page.dart';


void main() {
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity:  VisualDensity.adaptivePlatformDensity,
      ),
      home: MinhaHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MinhaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _screen();
  }

  Widget _screen() {
    return Stack(
      children:<Widget> [
        SplashScreen(
          seconds: 5,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffED213A),Color(0xff93291E)]),
          navigateAfterSeconds: LoginPage(),
          loaderColor: Colors.transparent,
        ),
        Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage("assets/images/logo2.png"),
              fit: BoxFit.none,
              scale: 6.0,
            ) ,
          ),
        )
      ],
    );

  }
}