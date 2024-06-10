import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
final firebase  = FirebaseAuth.instance;
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final form = GlobalKey<FormState>();
  var enteredemail = '';
  var enteredpassword = '';
  void sumbit() async {
    final isvalid = form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    form.currentState?.save();
    print(enteredemail);
    try {
      print(enteredemail);
      final result  = await firebase.createUserWithEmailAndPassword(email: enteredemail, password: enteredpassword);
      print(result);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if(e.code=='email-already-in-use'){
        //...
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message??'Authentication failed.'))
      );
    }
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
                "Create your account!",
                textWidthBasis: TextWidthBasis.longestLine,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            
            // const SizedBox(height: 10),
            const Text(
              "Email",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              validator: (value){
                if(value==null || value.trim().isEmpty || !value.contains('@')){
                  return 'Please enter valid email id';
                }
                return null;
              },
              onSaved: (value){
                enteredemail = value!;
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
              validator: (value){
                if(value==null || value.trim().length < 6){
                  return 'Please enter valid password';
                }
                return null;
              },
              onSaved: (value){
                enteredpassword = value!;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: double.maxFinite,
                height: 42,
                child: ElevatedButton(
                  onPressed: (){sumbit();},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 75, 221, 31)),
                  ),
                  child: const Text(
                    "SignUp",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                )),
            const SizedBox(height: 15),
            const SizedBox(
              width: double.maxFinite,
              child: Text(
                "or sign up with",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 224, 224, 226), // Set background color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const IconButton(
                    icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
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
                  child: const IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
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
                  child: const IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter,
                        color: Colors.lightBlue),
                    onPressed: AboutDialog.new,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Have an account?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 14, 187, 51)),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}