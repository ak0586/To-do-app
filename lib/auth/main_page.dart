//main_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application_with_firebase/auth/auth_page.dart';
import 'package:todo_application_with_firebase/screen/home.dart';
// import 'package:todo_application_with_firebase/const/colors.dart';
// import 'package:todo_application_with_firebase/screen/login.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

// bool a = true;

class _Main_PageState extends State<Main_Page> {
  // void to() {
  //   setState(() {
  //     a = !a;
  //   });
  // }

  // void _logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacement(
  //     MaterialPageRoute(
  //         builder: (context) => LogIN_Screen(to)), // Navigate to login screen
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // // appBar: AppBar(
      // //   title: const Text(
      // //     'Todo App',
      // //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      // //   ),
      // //   actions: [
      // //     IconButton(
      // //       icon: const Icon(Icons.logout),
      // //       onPressed: _logout,
      // //     ),
      // //   ],
      // //   // centerTitle: true,
      // //   backgroundColor: custom_green,
      // ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const Home_Screen();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else {
            return Auth_Page();
          }
        },
      ),
    );
  }
}
