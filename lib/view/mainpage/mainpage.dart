import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/controller/getusername.dart';
import 'package:step_counter/widget/pages/mainpage/mainpagelogic.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainController controller;
  List<String> docIDs = [];

  @override
  void initState() {
    super.initState();
    controller = MainController(context: context);
    fetchDocIds();
  }

  Future<void> fetchDocIds() async {
    final ids = await controller.getDocIds();
    setState(() {
      docIDs = ids;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              userId == null
                  ? const Text("No user logged in.")
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetUsername(userId: userId),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.signOut,
                        child: const Text("Log Out"),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
