import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_application_with_firebase/const/colors.dart';
import 'package:todo_application_with_firebase/screen/add_note_screen.dart';
import 'package:todo_application_with_firebase/widgets/stream_note.dart';

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
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Tasks, Have to Completed',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold),
                ),
                Stream_note(false),
                const SizedBox(
                    height: 20,
                    child:
                        Text('--------------------------------------------')),
                Text(
                  'Tasks Completed',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold),
                ),
                Stream_note(true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
