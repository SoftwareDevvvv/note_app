import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'accent_color_screen.dart';
import 'trash_management_screen.dart';
import '../../tags/screens/tag_management_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: ShibaNoteTheme.backgroundColor,
              ),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: ShibaNoteTheme.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Settings',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: ShibaNoteTheme.foregroundColor,
                            letterSpacing: -0.25,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Customize your ShiboNote experience',
                          style: const TextStyle(
                            fontSize: 12,
                            color: ShibaNoteTheme.mutedForeground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Appearance Section
                    _buildSettingsSection(
                      context,
                      'Appearance',
                      [
                        SettingsItem(
                          title: 'Change Accent Color',
                          subtitle: 'Choose from Shiba palette',
                          icon: Icons.palette_outlined,
                          onTap: () {
                            // Navigate to accent color settings
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AccentColorScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Storage Section
                    _buildSettingsSection(
                      context,
                      'Organization',
                      [
                        SettingsItem(
                          title: 'Manage Tags',
                          subtitle: 'Create, edit, and organize your tags',
                          icon: Icons.local_offer_outlined,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TagManagementScreen(),
                              ),
                            );
                          },
                        ),
                        SettingsItem(
                          title: 'Manage Trash',
                          subtitle: 'Auto-clean settings',
                          icon: Icons.delete_outline,
                          onTap: () {
                            // Navigate to trash management settings
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TrashManagementScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    String title,
    List<SettingsItem> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ShibaNoteTheme.foregroundColor,
          ),
        ),
        const SizedBox(height: 12),

        // Settings Card
        Container(
          decoration: BoxDecoration(
            color: ShibaNoteTheme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ShibaNoteTheme.borderColor.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                offset: Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: item.onTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Icon with background
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: ShibaNoteTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item.icon,
                                size: 20,
                                color: ShibaNoteTheme.primaryColor,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Title and Subtitle
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ShibaNoteTheme.foregroundColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: ShibaNoteTheme.mutedForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Chevron Right
                            const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: ShibaNoteTheme.mutedForeground,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Divider (except for last item)
                  if (!isLast)
                    Container(
                      margin: const EdgeInsets.only(left: 60),
                      height: 1,
                      color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SettingsItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
}
