import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserWelcome extends StatelessWidget {
  const UserWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Row(
        children: const [
          CircleAvatar(radius: 22, child: Icon(Icons.person)),
          SizedBox(width: 12),
          Text('Not logged in'),
        ],
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Row(
            children: const [
              CircleAvatar(radius: 22, child: Icon(Icons.person)),
              SizedBox(width: 12),
              Text('Loading...'),
            ],
          );
        }

        final data = snapshot.data!.data()!;
        final fullName = data['fullName'] ?? 'Student';
        final photoUrl = data['profileImageUrl'] ?? '';

        return Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: photoUrl.isNotEmpty
                  ? NetworkImage(photoUrl)
                  : const AssetImage('assets/images/pngwing.png')
                        as ImageProvider,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? const Color(0xFFA4B89D) : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Hello, $fullName',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
