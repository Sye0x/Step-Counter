import 'package:flutter/material.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/widget/mainscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor, // Global background color
      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
