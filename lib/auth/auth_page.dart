//auth_page.dart
import 'package:flutter/material.dart';
import 'package:todo_application_with_firebase/screen/SingUP.dart';
import 'package:todo_application_with_firebase/screen/login.dart';

class Auth_Page extends StatefulWidget {
  Auth_Page({super.key});

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LogIN_Screen(to);
    } else {
      return SignUp_Screen(to);
    }
  }
}