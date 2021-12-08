// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app_local/auth/components/background.dart';
import 'package:flutter_app_local/auth/components/rounded_button.dart';
import 'package:flutter_app_local/auth/components/rounded_input_field.dart';
import 'package:flutter_app_local/auth/components/text_field_container.dart';
import 'package:flutter_app_local/auth/register/register_screen.dart';

class Body extends StatelessWidget {
    late String _eMail;
    late String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    
    return Background(
      headerText: "Login",
      haveBackButton: false,
      onBackButtonPress: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedInputField(
            hintText: "E-mail",
            onChanged: (value) { _eMail = value; },
            isTextHidden: false,
          ),
          RoundedInputField(
            hintText: "Password",
            onChanged: (value) { _password = value; },
            isTextHidden: true
          ),
          RoundedButton(
            text: "Login",
            onPress: () { _login(); },
          ),
          Text(
            "Don`t have an account?",
            style: TextStyle(color: Color.fromARGB(255, 146, 146, 146), fontWeight: FontWeight.w300, fontSize: 20),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterScreen();
                  },
                ),
              );
            },
            child: Text(
              "Register",
              style: TextStyle(color: Color.fromARGB(255, 228, 121, 120), fontWeight: FontWeight.w300, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    log(_eMail + " " + _password);
  }
}
