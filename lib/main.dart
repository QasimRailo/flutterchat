import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/screens/chat_screen.dart';
import 'package:flutterchat/screens/login_screen.dart';
import 'package:flutterchat/screens/registration_screen.dart';
import 'package:flutterchat/screens/welcome_screen.dart';
// import 'package:flash_chat/screens/welcome_screen.dart';
// import 'package:flash_chat/screens/login_screen.dart';
// import 'package:flash_chat/screens/registration_screen.dart';
// import 'package:flash_chat/screens/chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     // bodyText1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: const Color(0xFF0A0E21),
      //   colorScheme: const ColorScheme.light().copyWith(
      //     primary: const Color(0xFF0A0E21),
      //     // secondary: Colors.purple,
      //   ),
      // ),

      // home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
