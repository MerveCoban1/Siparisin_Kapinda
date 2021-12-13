import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siparisin_kapinda/auth/user_model.dart';
import 'package:siparisin_kapinda/globals.dart' as globals;

class AuthService {

  Future createUser(String email, String firstName, String lastName, String phoneNumber, String password, String passwordAgain) async {
    var userQuery = await FirebaseFirestore.instance.collection('users').get();
    int lastId = 0;
    for(var sn in userQuery.docs){
      lastId = sn.data()['userId'];
    }
    lastId++;
    if(password == passwordAgain){
      FirebaseFirestore.instance
          .collection('users')
          .add(UserModel(email, firstName, lastName, phoneNumber, password, lastId).toJson());  
    }
  }

  void login(String email, String password) async {
    var userQuery = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
    if(userQuery.docs.length == 1) {
      for(var sn in userQuery.docs){
        if(sn.data()['password'].toString() == password){
          globals.loggedUserId = sn.data()['userId'];
        }
      }
    }
  }

  Future<UserModel> getUserById(int userId) async {
    UserModel user = UserModel('', '', '', '', '', 0);
    var userQuery = await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: userId).get();
    if(userQuery.docs.length == 1) {
      for(var sn in userQuery.docs) {
        user.email = sn.data()['email'].toString();
        user.firstName = sn.data()['firstName'].toString();
        user.lastName = sn.data()['lastName'].toString();
        user.phoneNumber = sn.data()['phoneNumber'].toString();
      }
    }
    return user;
  }
}