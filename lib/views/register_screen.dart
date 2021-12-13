import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/auth/auth_service.dart';
import '/auth/components/background.dart';
import '/auth/components/rounded_input_field.dart';
import '/auth/components/rounded_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  late String _eMail;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _password;
  late String _passwordAgain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}

class Body extends StatelessWidget {
  late String _eMail;
  late String _firstName;
  late String _lastName;
  late String _phoneNumber;
  late String _password;
  late String _passwordAgain;

  AuthService service = AuthService();

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
            onPress: () { _register(context); },
          ),
        ],
      ),
    );
  }

  void _register(BuildContext context) {
    service.createUser(this._eMail, this._firstName, this._lastName, this._phoneNumber, this._password, this._passwordAgain);
    Navigator.push(context, MaterialPageRoute(builder: (context) { return LoginScreen();}));
  }
}