import 'package:flutter/material.dart';
import 'package:uni_process_hub/core/theme/app_color.dart';
import 'package:uni_process_hub/features/profile/widgets/academic_details_card.dart';
import 'package:uni_process_hub/features/profile/widgets/activity_section.dart';
import 'package:uni_process_hub/features/profile/widgets/contact_info_section.dart';
import 'package:uni_process_hub/features/profile/widgets/help_support_section.dart';
import 'package:uni_process_hub/features/auth/widgets/logout_section.dart';
import 'package:uni_process_hub/features/profile/widgets/profile_avatar.dart';
import 'package:uni_process_hub/features/profile/widgets/profile_header.dart';
import 'package:uni_process_hub/features/profile/widgets/settings_section.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // sticky top header
            const ProfileHeader(),
            // body scrollable region
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        // avatar area
                        SizedBox(height: 12),
                        ProfileAvatar(),
                        SizedBox(height: 16),
                        AcademicDetailsCard(),
                        SizedBox(height: 12),
                        ActivitySection(),
                        SizedBox(height: 12),
                        SettingsSection(),
                        SizedBox(height: 12),
                        ContactInfoSection(),
                        SizedBox(height: 12),
                        HelpSupportSection(),
                        SizedBox(height: 12),
                        LogoutSection(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
