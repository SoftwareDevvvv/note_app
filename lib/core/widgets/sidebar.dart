import 'package:flutter/material.dart';
import 'package:note_app/core/theme/app_theme.dart';
import '../modules/trash/screens/trash_screen.dart';
import '../modules/settings/screens/settings_screen.dart';
import '../modules/favorites/screens/favorites_screen.dart';

class ShibaNoteSidebar extends StatelessWidget {
  const ShibaNoteSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288, // w-72 equivalent (288px)
      color: ShibaNoteTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'ShiboNote',
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20, // text-xl
                        fontWeight: FontWeight.w700, // font-bold
                        color: ShibaNoteTheme.foregroundColor, // text-foreground
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: ShibaNoteTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content with sections
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24), // mt-6 equivalent

                    // Navigation Section
                    _buildSection(
                      title: 'NAVIGATION',
                      items: [
                        _SidebarItem(
                          icon: Icons.description_outlined,
                          label: 'All Notes',
                          onTap: () {
                            Navigator.of(context).pop();
                            // Handle navigation to all notes
                          },
                        ),
                        _SidebarItem(
                          icon: Icons.favorite_outline,
                          label: 'Favorites',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24), // space-y-6

                    // Separator
                    Container(
                      height: 1,
                      color: ShibaNoteTheme.borderColor.withOpacity(0.5),
                    ),

                    const SizedBox(height: 24),

                    // Settings Section
                    _buildSection(
                      title: 'SETTINGS',
                      items: [
                        _SidebarItem(
                          icon: Icons.delete_outline,
                          label: 'Trash',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const TrashScreen()),
                            );
                          },
                        ),
                        _SidebarItem(
                          icon: Icons.settings_outlined,
                          label: 'Settings',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SettingsScreen()),
                            );
                          },
                        ),
                      ],
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_SidebarItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 12, // text-sm
            fontWeight: FontWeight.w500, // font-medium
            color: ShibaNoteTheme.mutedForeground, // text-muted-foreground
            letterSpacing: 0.5, // tracking-wide
          ),
        ),
        const SizedBox(height: 8), // space-y-2
        
        // Menu items
        Column(
          children: items.map((item) => _buildMenuItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuItem(_SidebarItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4), // space-y-1
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(8),
          hoverColor: ShibaNoteTheme.mutedColor.withOpacity(0.5),
          splashColor: ShibaNoteTheme.primaryColor.withOpacity(0.1),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12), // p-3 equivalent
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20, // h-5 w-5
                  color: ShibaNoteTheme.textSecondary,
                ),
                const SizedBox(width: 12), // mr-3
                Expanded(
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ShibaNoteTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
