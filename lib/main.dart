import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.pathName,
      routes: {
        '/' : (context) => WelcomeScreen(),
        WelcomeScreen.pathName : (context) => WelcomeScreen(),
        ChatScreen.pathName : (context) => ChatScreen(),
        LoginScreen.pathName : (context) => LoginScreen(),
        RegistrationScreen.pathName : (context) => RegistrationScreen()
      },
    );
  }
}
