import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';
import 'package:flash_chat/widget/round_button_widget.dart';
import 'package:flash_chat/widget/email_text_form_field.dart';
import 'package:flash_chat/widget/password_text_form_field.dart';
import 'package:flash_chat/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String pathName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _form = GlobalKey<FormState>();

  String email;
  String password;

  @override
  void initState() {
    super.initState();
//    bool isAlreadyConnected = await getFirebaseUser();
//    if(isAlreadyConnected) {
//      Navigator.popAndPushNamed(context, ChatScreen.pathName);
//    }
  }

  Future<bool> getFirebaseUser() async {
    try {
      FirebaseUser firebaseUser = await _auth.currentUser();
      if (firebaseUser != null) {
        print(firebaseUser.email);
        return true;
      } else {
        print('error');
        return false;
      }
    } on Exception catch (e) {
      // TODO
      print(e);
      return false;
    }
  }

  void registerNewUser() async {
    try {
      FirebaseUser firebaseUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser != null) {
        Navigator.popAndPushNamed(context, ChatScreen.pathName);
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
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              PasswordTextFormField(
                onSaved: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButtonWidget(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () {
                  if(_form.currentState.validate()) {
                    _form.currentState.save();
                    registerNewUser();
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
