import 'package:flutter/material.dart';
import 'package:flutterchat/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/Roundedbutton.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      // upperBound: 100,
    );
    animation =
        ColorTween(begin: Colors.red, end: Colors.white).animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    // animation.addStatusListener((status) {
    //   print(status);
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1);
    //   }else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });
    controller.reverse(from: 0.5);
    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      child: Image.asset('images/logo.png'), height: 70.0),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              color: Colors.blue,
              title: 'login',
              fun: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              color: Colors.blue,
              title: 'Register',
              fun: () {
                //Go to login screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
