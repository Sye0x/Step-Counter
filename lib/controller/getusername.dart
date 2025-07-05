import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetUsername extends StatelessWidget {
  const GetUsername({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");

    // Use the document directly by UID for efficiency and clarity
    final userDoc = users.doc(userId).get();

    return FutureBuilder<DocumentSnapshot>(
      future: userDoc,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Error loading user");
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("User not found");
        } else {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final username = userData['username'] ?? 'No username';

          return Text(
            'Hello $username',
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          );
        }
      },
    );
  }
}
