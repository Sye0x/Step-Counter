import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUsername extends StatelessWidget {
  const GetUsername({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("Users");

    // Query Firestore for documents where 'uid' == userId
    Future<QuerySnapshot> userQuery =
        users.where('uid', isEqualTo: userId).get();

    return FutureBuilder<QuerySnapshot>(
      future: userQuery,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Text('No user found with this ID.');
          } else {
            // If you expect only one user document per uid, take the first
            final userData = docs.first.data() as Map<String, dynamic>;
            final username = userData['username'] ?? 'No username';

            return Text(
              'Username: $username',
              style: TextStyle(color: Colors.white),
            );
          }
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
