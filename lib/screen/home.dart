import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:todo_application_with_firebase/const/colors.dart';
import 'package:todo_application_with_firebase/screen/add_note_screen.dart';
import 'package:todo_application_with_firebase/screen/login.dart'; // Import your login screen
import 'package:todo_application_with_firebase/widgets/stream_note.dart';
import 'package:todo_application_with_firebase/data/firestor.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 220, 213),
        title: const Text('Tasks'),
      ),
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Add_screen(),
            ));
          },
          backgroundColor: custom_green,
          child: const Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always show the "Tasks, Have to be Completed" text with count
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: Firestore_Datasource().stream(false),
                builder: (context, snapshot) {
                  int count = 0;
                  if (snapshot.hasData) {
                    count = snapshot.data!.docs.length;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tasks, Have to be Completed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '($count)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // "Tasks, Have to be Completed" section
            StreamBuilder(
              stream: Firestore_Datasource().stream(false),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Expanded(
                    child: Stream_note(false),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Shrinks when no tasks are present
                }
              },
            ),

            const Divider(), // Divider to separate the lists

            // Always show the "Tasks Completed" text with count
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: Firestore_Datasource().stream(true),
                builder: (context, snapshot) {
                  int count = 0;
                  if (snapshot.hasData) {
                    count = snapshot.data!.docs.length;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tasks Completed',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '($count)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // "Tasks Completed" section
            StreamBuilder(
              stream: Firestore_Datasource().stream(true),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Expanded(
                    child: Stream_note(true),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Shrinks when no tasks are present
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
