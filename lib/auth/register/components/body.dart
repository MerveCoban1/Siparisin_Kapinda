import 'package:flutter/material.dart';
import 'package:flutter_app_local/auth/components/background.dart';
import 'package:flutter_app_local/auth/components/rounded_button.dart';
import 'package:flutter_app_local/auth/components/rounded_input_field.dart';
import 'package:flutter_app_local/auth/login/login_screen.dart';

class Body extends StatelessWidget {
  late String _eMail;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _password;
  late String _passwordAgain;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      headerText: "Register",
      haveBackButton: true,
      onBackButtonPress: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedInputField(
            hintText: "E-mail",
            onChanged: (value) { _eMail = value; },
            isTextHidden: false,
          ),
          RoundedInputField(
            hintText: "First Name",
            onChanged: (value) { _firstName = value; },
            isTextHidden: false,
          ),
          RoundedInputField(
            hintText: "Last Name",
            onChanged: (value) { _lastName = value; },
            isTextHidden: false,
          ),
          RoundedInputField(
            hintText: "Phone Number",
            onChanged: (value) { _phoneNumber = value; },
            isTextHidden: false,
          ),
          RoundedInputField(
            hintText: "Password",
            onChanged: (value) { _password = value; },
            isTextHidden: true,
          ),
          RoundedInputField(
            hintText: "Password Again",
            onChanged: (value) { _passwordAgain = value; },
            isTextHidden: true,
          ),
          RoundedButton(
            text: "Register",
            onPress: () { _register(); },
          ),
        ],
      ),
    );
  }

  void _register() {

  }
}