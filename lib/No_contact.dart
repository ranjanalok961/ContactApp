
import 'package:flutter/material.dart';

class NoContact extends StatefulWidget {
  @override
  _NoContactState createState() => _NoContactState();
}

class _NoContactState extends State<NoContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/nocontact.png',
              fit: BoxFit.contain, 
            ),
          ),
        ),
      ),
    );
  }
}