import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.white;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;

  const BaseAppBar({required this.title, required this.appBar, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.grey[400],
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60.0);
}