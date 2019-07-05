import 'package:flutter/material.dart';

import 'package:flash_chat/utils/utils.dart';
import 'package:flash_chat/constants.dart';

class EmailTextFormField extends StatelessWidget {

  final Function onSaved;

  EmailTextFormField({key: Key, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value.isEmpty) {
          return 'Please enter an email.';
        }

        if(!Utils.isEmailWellFormatted(value)) {
          return 'Email incorect';
        }

        return null;
      },
      onSaved: this.onSaved,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: kTextFieldDecoration.copyWith(
          hintText: 'Enter your email.'
      ),
    );
  }
}