import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String headerText;
  final bool haveBackButton;
  final VoidCallback onBackButtonPress;

  const Background({
    Key? key,
    required this.child,
    required this.headerText,
    required this.haveBackButton,
    required this.onBackButtonPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Visibility(
            visible: haveBackButton,
            child: Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                onPressed: onBackButtonPress,
                icon: const Icon(Icons.arrow_back)
              ),
            ),
          ),
          Positioned(
            top: 20,
            child: Text(
            headerText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 62, 62, 62)),
          ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/auth_bottom.png",
              width: size.width,
            ),
          ),
          child,
        ],
      ),
    );
  }
}