import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  User? user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    user = user;
    notifyListeners();
    
  }
}