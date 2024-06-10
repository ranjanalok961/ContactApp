import 'package:contactapp/SignUpScreen.dart';
import 'package:contactapp/YourWidgetName.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

final firebase = FirebaseAuth.instance;

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<Loginscreen> {
  final form = GlobalKey<FormState>();
  double _iconSize = 24.0;
  var enteredemail = '';
  var enteredpassword = '';
  void sumbit() async {
    final isvalid = form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    form.currentState?.save();
    print(enteredemail);
    print(enteredpassword);
    try {
      final result = await firebase.signInWithEmailAndPassword(
          email: enteredemail, password: enteredpassword);
      print('Hello ${result.user}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => YourWidgetName(enteredemail)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorMessage(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorMessage(context, 'Wrong password provided.');
      } else {
        _showErrorMessage(context, 'Sign in failed: ${e.message}');
      }
    } catch (e) {
      _showErrorMessage(context, 'Error: $e');
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: form,
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Sign in your account !",
                textWidthBasis: TextWidthBasis.longestLine,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Email",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    !value.contains('@')) {
                  return 'Please enter valid email id';
                }
                return null;
              },
              onSaved: (value) {
                enteredemail = value!.trim();
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Password",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().length < 6) {
                  return 'Please enter valid password';
                }
                return null;
              },
              onSaved: (value) {
                enteredpassword = value!.trim();
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.maxFinite,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    sumbit();
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 75, 221, 31)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            const SizedBox(height: 20),
            const SizedBox(
              width: double.maxFinite,
              child: Text(
                "or sign in with",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 224, 224, 226), // Set background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.google,
                        color: Colors.red, size: _iconSize),
                    onPressed: AboutDialog.new,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 224, 224, 226), // Set background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      size: _iconSize,
                    ),
                    onPressed: AboutDialog.new,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 224, 224, 226), // Set background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter,
                        color: Colors.lightBlue, size: _iconSize),
                    onPressed: AboutDialog.new,
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Don’t have an account?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 14, 187, 51)),
                          overflow: TextOverflow.ellipsis,
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
