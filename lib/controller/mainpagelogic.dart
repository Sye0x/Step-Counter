import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainController {
  final BuildContext context;

  MainController({required this.context});

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (e) {
      _showError("Error signing out: ${e.toString()}");
    }
  }

  Future<List<String>> getDocIds() async {
    List<String> docIDs = [];
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Users").get();
      for (var doc in snapshot.docs) {
        docIDs.add(doc.reference.id);
      }
    } catch (e) {
      _showError("Failed to fetch user IDs");
    }
    return docIDs;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
