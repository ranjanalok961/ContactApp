import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/splash.png',
            fit: BoxFit.cover, // Use BoxFit.cover to make the image cover the entire screen
          ),
        ),
      ),
    );
  }
}
