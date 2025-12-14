import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';

class ProfileImagePicker extends StatefulWidget {
  final double size;
  final String? imageUrl;
  final VoidCallback? onUploadComplete;

  const ProfileImagePicker({
    super.key,
    required this.size,
    this.imageUrl,
    this.onUploadComplete,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  bool _uploading = false;

  Future<void> _pickAndUpload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final picker = ImagePicker();
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (file == null) return;

    setState(() => _uploading = true);

    try {
      final ref = FirebaseStorage.instance.ref().child(
        'profile_images/${user.uid}.jpg',
      );

      if (kIsWeb) {
        await ref.putData(await file.readAsBytes());
      } else {
        await ref.putFile(File(file.path));
      }

      final url = await ref.getDownloadURL();
      await user.updatePhotoURL(url);

      widget.onUploadComplete?.call();
    } catch (e) {
      debugPrint('Profile upload error: $e');
    }

    setState(() => _uploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _uploading ? null : _pickAndUpload,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: widget.imageUrl != null
                ? Image.network(
                    widget.imageUrl!,
                    width: widget.size,
                    height: widget.size,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: widget.size,
                    height: widget.size,
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 48),
                  ),
          ),
          if (_uploading)
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: .5),
                ),
              ),
              child: const CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
    );
  }
}
