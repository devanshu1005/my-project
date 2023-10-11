import 'package:flutter/material.dart';
import 'package:my_project/models/user.dart';
import 'package:my_project/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  UserData? userdata;
}