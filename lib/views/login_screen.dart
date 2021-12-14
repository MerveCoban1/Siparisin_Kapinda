import 'package:flutter/material.dart';
import 'package:siparisin_kapinda/auth/auth_service.dart';
import 'dart:developer';
import '/auth/components/background.dart';
import '/auth/components/rounded_button.dart';
import '/auth/components/rounded_input_field.dart';
import '/views/home.dart';
import 'forgot_password_screen.dart';
import '../../views/register_screen.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(),);
  }
}


class Body extends StatelessWidget {
  late String _eMail;
  late String _password;

  AuthService service = AuthService();

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
            onPress: () { _login(context); },
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

          Text(
            "Forgot Passsword?",
            style: TextStyle(color: Color.fromARGB(255, 146, 146, 146), fontWeight: FontWeight.w300, fontSize: 20),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ForgotPasswordScreen();
                  },
                ),
              );
            },
            child: Text(
              "Reset Password",
              style: TextStyle(color: Color.fromARGB(255, 228, 121, 120), fontWeight: FontWeight.w300, fontSize: 20),
            ),
          ),



        ],
      ),
    );
  }

  void _login(BuildContext context) {
    service.login(this._eMail, this._password);
    Navigator.push(context, MaterialPageRoute(builder: (context) { return Home();}));
  }
}
