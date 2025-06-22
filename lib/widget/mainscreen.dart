import 'package:flutter/material.dart';
import 'package:step_counter/widget/pages/signup/signup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Signup());
  }
}
