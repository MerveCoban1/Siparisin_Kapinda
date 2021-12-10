import 'package:flutter/material.dart';
import '/auth/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool isTextHidden;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.isTextHidden,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isTextHidden,
        onChanged: onChanged,
        style: TextStyle(
          color: Color.fromARGB(255, 146, 146, 146),
          fontSize: 25,
          fontWeight: FontWeight.w200
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 146, 146, 146)
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}