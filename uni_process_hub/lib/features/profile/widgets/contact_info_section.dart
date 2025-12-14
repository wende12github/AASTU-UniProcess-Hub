import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';

class ContactInfoSection extends StatefulWidget {
  const ContactInfoSection({super.key});

  @override
  State<ContactInfoSection> createState() => _ContactInfoSectionState();
}

class _ContactInfoSectionState extends State<ContactInfoSection> {
  String? email;
  String? phone;
  String? fullName;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchContactInfo();
  }

  Future<void> _fetchContactInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        email = data['email'] ?? 'N/A';
        phone = data['phone'] ?? 'N/A';
        fullName = data['fullName'] ?? 'Student';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.surfaceDark : Colors.white;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Info',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.grey.shade100,
              ),
            ),
            child: Column(
              children: [
                _contactRow(Icons.mail, 'University Email', email ?? 'N/A'),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.grey.shade100,
                ),
                _contactRow(
                  Icons.call,
                  'Mobile Number',
                  phone ?? 'N/A',
                  trailingIcon: Icons.edit,
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.white10 : Colors.grey.shade100,
                ),
                _contactRow(
                  Icons.medical_services,
                  'Emergency Contact',
                  fullName ??
                      'Student'
                          ' (Father)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(
    IconData leading,
    String label,
    String value, {
    IconData? trailingIcon,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Icon(leading, color: Colors.grey[600]),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
      trailing: trailingIcon != null
          ? Icon(trailingIcon)
          : const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
