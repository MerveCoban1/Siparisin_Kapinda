import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '/auth/components/background.dart';
import '/auth/components/rounded_button.dart';
import '/auth/components/rounded_input_field.dart';
import '../../views/pasword_reset_complete.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(),);
  }
}

class Body extends StatelessWidget {
  late String _eMail;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Background(
      headerText: "Şifre Sıfırla",
      haveBackButton: true,
      onBackButtonPress: () { _backButton(context); },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              "Kullanıcı adınızı veya e-posta adresinizi girin, şifrenizi nasıl sıfırlayacağınızla ilgili talimatları size e-posta ile gönderelim.\n",
              style: TextStyle(color: Color.fromARGB(255, 146, 146, 146), fontWeight: FontWeight.w300, fontSize: 20), textAlign: TextAlign.center
          ),
          RoundedInputField(
            hintText: "E-posta veya Kullanıcı Adı",
            onChanged: (value) { _eMail = value; },
            isTextHidden: false,
          ),
          RoundedButton(
            text: "Gönder",
            onPress: () { _submit(context); },
          ),


        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    log(_eMail);
    Navigator.push(context, MaterialPageRoute(builder: (context) { return PasswordResetComplete();}));
  }

  void _backButton(BuildContext context){
    Navigator.pop(context);
  }

}
