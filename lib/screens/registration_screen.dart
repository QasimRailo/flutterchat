import 'package:flutter/material.dart';
import '../components/Roundedbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'login_screen.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registeration";

  RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
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
                  title: 'Register',
                  fun: () async {
                    // print(email);
                    // print(password);
                    final progress = ProgressHUD.of(context);
                    setState(() {
                      progress?.show();
                    });

                    // Future.delayed(Duration(seconds: 1), () {
                    //   progress?.dismiss();
                    // });
                    try {
                      final newUSer =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUSer != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          //showSpinner = false;
                          progress?.dismiss();
                        });
                      }
                    } catch (e) {
                      setState(() {
                        //showSpinner = false;
                        progress?.dismiss();
                      });
                      print(e);
                    }
                    //  Navigator.pushNamed(context, LoginScreen.id);
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
