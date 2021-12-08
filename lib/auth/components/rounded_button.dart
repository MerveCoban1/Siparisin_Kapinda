import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.7,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Color.fromARGB(255, 228, 121, 120),
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }
}