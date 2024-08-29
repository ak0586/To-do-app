import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application_with_firebase/auth/auth_page.dart';
import 'package:todo_application_with_firebase/screen/home.dart';
import 'package:todo_application_with_firebase/const/colors.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: custom_green,
        title: const Text(
          'Todo App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Home_Screen();
          } else {
            return Auth_Page();
          }
        },
      ),
    );
  }
}
