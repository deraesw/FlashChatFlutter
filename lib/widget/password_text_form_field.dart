import 'package:flutter/material.dart';

import 'package:flash_chat/constants.dart';

class PasswordTextFormField extends StatelessWidget {

  final Function onSaved;

  PasswordTextFormField({key: Key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a password.';
        }

        if (value.length < 6) {
          return 'Password must be at least 6.';
        }

        return null;
      },
      onSaved: this.onSaved,
      textAlign: TextAlign.center,
      obscureText: true,
      decoration: kTextFieldDecoration.copyWith(
        hintText: 'Enter your password',
      ),
    );
  }
}
