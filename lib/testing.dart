//material gurl
// type mateapp , to automatically generate the material / main
import 'package:flutter/material.dart';
//import section
//void main() => runApp(const MyApp());//only for 1 command

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); //parent class constructor must same as class name
//class is Green
//light blue is warning,,, ywllow is action to be taken
//light blue is warning but still can be run.
//ctrl + spacebars
// ctrl + shift + F
//
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Za warudo!'),
        ),
      ),
    );
  }
}
