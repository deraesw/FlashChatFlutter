import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'package:flash_chat/widget/round_button_widget.dart';
import 'package:flash_chat/widget/email_text_form_field.dart';
import 'package:flash_chat/widget/password_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String pathName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>();

  String _password;
  String _email;

  void _logInUser() async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
      if(user != null) {
        Navigator.popAndPushNamed(context, ChatScreen.pathName);
      } else {
        //TODO to handle
        print('no user');
      }
    } on Exception catch (e) {
      // TODO
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              EmailTextFormField(
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              PasswordTextFormField(
                onSaved: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButtonWidget(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {
                  if(_form.currentState.validate()) {
                    _form.currentState.save();
                    _logInUser();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

