import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/auth/components/background.dart';
import '../../views/login_screen.dart';

class PasswordResetComplete extends StatelessWidget {
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
              "Talimatlat e-posta adresinize gönderildi.\n Şifrenizi sıfırlamak için e-posta adresinizi kontrol edin.",
              style: TextStyle(color: Color.fromARGB(255, 146, 146, 146), fontWeight: FontWeight.w300, fontSize: 20), textAlign: TextAlign.center
          ),

        ],
      ),
    );
  }

  void _backButton(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) { return LoginScreen();}));
  }

}
