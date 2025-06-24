import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:step_counter/widget/pages/login/login.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.email;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello $user", style: TextStyle(color: Colors.white)),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
