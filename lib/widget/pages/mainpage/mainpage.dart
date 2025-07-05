import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:step_counter/controller/getusername.dart";
import "package:step_counter/widget/pages/login/login.dart";

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser?.email;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection("Users").get().then((snapshot) {
      for (var doc in snapshot.docs) {
        docIDs.add(doc.reference.id);
      }
    });
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  Future<void> signOut() async {
    try {
      // Sign out from Firebase Auth
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In to clear cached account
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed out successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign out failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetUsername(userId: FirebaseAuth.instance.currentUser!.uid),
              ElevatedButton(onPressed: signOut, child: Text("Log Out")),
            ],
          ),
        ),
      ),
    );
  }
}
