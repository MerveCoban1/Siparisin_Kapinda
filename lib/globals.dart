library siparisin_kapinda.globals;

import 'package:shared_preferences/shared_preferences.dart';

int _loggedUserId = 0;

int get loggedUserId => _loggedUserId;

set loggedUserId(int value) {
  _loggedUserId = value;
  SetLoggedUserId();
}

void OnStart() async {
  final prefs = await SharedPreferences.getInstance();
  _loggedUserId = prefs.getInt('loggedUserId') ?? 0;
}

void SetLoggedUserId() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('loggedUserId', _loggedUserId);
}