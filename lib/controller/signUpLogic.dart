// lib/controllers/signup_controller.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupController {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController fullNameController;
  final TextEditingController userNameController;
  final BuildContext context;

  SignupController({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.fullNameController,
    required this.userNameController,
    required this.context,
  });

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final username = userNameController.text.trim();

    if (password != confirmPassword) {
      showErrorDialog(
        "Passwords do not match",
        "Please re-enter your password.",
      );
      passwordController.clear();
      confirmPasswordController.clear();
      return;
    }

    if (!isPasswordValid(password)) {
      showErrorDialog(
        "Weak Password",
        "Password must be at least 8 characters long and include:\n- 1 uppercase letter\n- 1 number\n- 1 special character",
      );
      return;
    }

    try {
      final usersRef = FirebaseFirestore.instance.collection("Users");

      final emailQuery = await usersRef.where("email", isEqualTo: email).get();
      if (emailQuery.docs.isNotEmpty) {
        showErrorDialog(
          "Email already registered",
          "Please use a different email.",
        );
        return;
      }

      final usernameQuery =
          await usersRef.where("username", isEqualTo: username).get();
      if (usernameQuery.docs.isNotEmpty) {
        showErrorDialog("Username taken", "Please choose another username.");
        return;
      }

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await addUserDetails(userCredential.user!.uid);

      await FirebaseAuth.instance.signOut();

      if (context.mounted) Navigator.pop(context);
    } catch (e) {
      showErrorDialog("Sign up failed", e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) return;

      final usersRef = FirebaseFirestore.instance.collection("Users");
      final emailQuery =
          await usersRef.where("email", isEqualTo: user.email).get();

      if (emailQuery.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This email is already registered.")),
        );
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        return;
      }

      if (!context.mounted) return;

      final result = await Navigator.pushNamed<String>(context, '/setusername');

      if (!context.mounted || result == null || result.trim().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Username not provided.")));
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        return;
      }

      final usernameQuery =
          await usersRef.where("username", isEqualTo: result.trim()).get();
      if (usernameQuery.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username is already taken.")),
        );
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        return;
      }

      await usersRef.doc(user.uid).set({
        "uid": user.uid,
        "fullname": user.displayName ?? "",
        "username": result.trim(),
        "email": user.email ?? "",
      });

      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Sign-in failed: $e")));
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }
  }

  bool isPasswordValid(String password) {
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Okay"),
              ),
            ],
          ),
    );
  }

  Future<void> addUserDetails(String uid) async {
    await FirebaseFirestore.instance.collection("Users").doc(uid).set({
      "uid": uid,
      "fullname": fullNameController.text.trim(),
      "username": userNameController.text.trim(),
      "email": emailController.text.trim(),
    });

    fullNameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
