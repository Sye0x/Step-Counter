import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
  }

  Future<void> sendLink(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      _showDialog(context, "Link Sent Successfully");
    } on FirebaseAuthException catch (e) {
      _showDialog(context, e.message ?? "An error occurred");
    }
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            content: Text(message, style: const TextStyle(color: Colors.black)),
          ),
    );
  }
}
