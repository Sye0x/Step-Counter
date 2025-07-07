import 'package:flutter/material.dart';

class SetUsernameController {
  final BuildContext context;
  final TextEditingController userNameController = TextEditingController();

  SetUsernameController(this.context);

  void submitUsername() {
    final username = userNameController.text.trim();

    if (username.isNotEmpty) {
      Navigator.pop(context, username);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter a username")));
    }
  }

  void dispose() {
    userNameController.dispose();
  }
}
