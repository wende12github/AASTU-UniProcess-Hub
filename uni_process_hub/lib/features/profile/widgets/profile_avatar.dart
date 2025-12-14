import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/features/profile/widgets/profile_image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Safety check
    if (user == null) {
      return const Center(child: Text('Not logged in'));
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Profile not found');
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final fullName = data['fullName'] ?? 'Student';
        final studentId = data['studentId'] ?? 'N/A';
        final department = data['department'] ?? '';
        final year = data['yearOfStudy'] ?? '';
        // final photoUrl = user!.photoURL;
        final photoUrl = data['profileImageUrl'] as String? ?? user!.photoURL;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 24),
                  // Profile Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ProfileImagePicker(
                        size: 104,
                        imageUrl: photoUrl,
                        onUploadComplete: () {
                          setState(() {});
                          // (context as Element).markNeedsBuild();
                        },
                      ),
                      // Camera Icon
                      Container(
                        margin: const EdgeInsets.only(right: 2, bottom: 2),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? AppColors.surfaceDarker
                                : Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.photo_camera,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // User Name
                  Text(
                    fullName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  // Role and User ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: .18),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ID: $studentId',
                        style: TextStyle(
                          color: isDark
                              ? const Color(0xFFA4B89D)
                              : Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Department and Year
                  Text(
                    '$department • Year $year',
                    style: TextStyle(
                      color: isDark
                          ? const Color(0xFFA4B89D)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
              // Edit Button
              Positioned(
                top: 0,
                right: 0,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
