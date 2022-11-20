import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutterchat/screens/chat_screen.dart';
import '../components/Roundedbutton.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: SizedBox(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter Email'),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  color: Colors.blue,
                  title: 'Login',
                  fun: () async {
                    // print("REGISTER");
                    //Go to login screen.
                    //  Navigator.pushNamed(context, LoginScreen.id);
                    final progress = ProgressHUD.of(context);
                    setState(() {
                      progress?.show();
                    });
                    try {
                      final newUSer = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUSer != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          progress?.dismiss();
                        });
                      }
                    } catch (e) {
                      setState(() {
                        progress?.dismiss();
                      });
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
