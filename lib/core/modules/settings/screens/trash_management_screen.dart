import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../trash/screens/trash_screen.dart';

class TrashManagementScreen extends StatefulWidget {
  const TrashManagementScreen({Key? key}) : super(key: key);

  @override
  State<TrashManagementScreen> createState() => _TrashManagementScreenState();
}

class _TrashManagementScreenState extends State<TrashManagementScreen> {
  bool autoCleanEnabled = true;
  String cleanupPeriod = "30";

  final List<CleanupOption> cleanupOptions = [
    CleanupOption(value: "7", label: "7 days"),
    CleanupOption(value: "14", label: "14 days"),
    CleanupOption(value: "30", label: "30 days"),
    CleanupOption(value: "60", label: "60 days"),
    CleanupOption(value: "90", label: "90 days"),
  ];

  void handleSave() {
    // TODO: Implement settings saving logic
    print("Saving trash settings: autoClean=$autoCleanEnabled, period=$cleanupPeriod");
    Navigator.of(context).pop();
  }

  void showCleanupPeriodPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ShibaNoteTheme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ShibaNoteTheme.mutedForeground.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Clean up notes older than:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ShibaNoteTheme.foregroundColor,
              ),
            ),
            const SizedBox(height: 20),
            ...cleanupOptions.map((option) {
              final isSelected = cleanupPeriod == option.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        cleanupPeriod = option.value;
                      });
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? ShibaNoteTheme.primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected 
                            ? Border.all(color: ShibaNoteTheme.primaryColor)
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option.label,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected 
                                    ? ShibaNoteTheme.primaryColor 
                                    : ShibaNoteTheme.foregroundColor,
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: ShibaNoteTheme.primaryColor,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

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
                          'Trash Management',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ShibaNoteTheme.foregroundColor,
                            letterSpacing: -0.25,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Configure automatic cleanup',
                          style: const TextStyle(
                            fontSize: 12,
                            color: ShibaNoteTheme.mutedForeground,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Save Button
                  GestureDetector(
                    onTap: handleSave,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Save',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ShibaNoteTheme.primaryForeground,
                        ),
                      ),
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

                    // Auto-Clean Settings Card
                    Container(
                      padding: const EdgeInsets.all(24),
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
                        children: [
                          // Auto-clean toggle
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Auto-clean trash',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: ShibaNoteTheme.foregroundColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Automatically delete old notes from trash',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: ShibaNoteTheme.mutedForeground,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: autoCleanEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    autoCleanEnabled = value;
                                  });
                                },
                                activeColor: ShibaNoteTheme.primaryColor,
                                inactiveThumbColor: ShibaNoteTheme.mutedForeground,
                                inactiveTrackColor: ShibaNoteTheme.mutedColor,
                              ),
                            ],
                          ),

                          // Cleanup period settings (shown when auto-clean is enabled)
                          if (autoCleanEnabled) ...[
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: ShibaNoteTheme.primaryColor.withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Clean up notes older than:',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ShibaNoteTheme.foregroundColor,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: showCleanupPeriodPicker,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ShibaNoteTheme.borderColor,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cleanupOptions
                                                    .firstWhere((option) => option.value == cleanupPeriod)
                                                    .label,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: ShibaNoteTheme.foregroundColor,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.expand_more,
                                              size: 20,
                                              color: ShibaNoteTheme.mutedForeground,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Information Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ShibaNoteTheme.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: ShibaNoteTheme.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How auto-clean works',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.foregroundColor,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Notes in trash older than the selected period will be permanently deleted. This happens automatically in the background and cannot be undone.',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: ShibaNoteTheme.mutedForeground,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Current Trash Status
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ShibaNoteTheme.mutedColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: ShibaNoteTheme.mutedForeground,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current trash',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.foregroundColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '2 notes • Oldest: 1 week ago',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: ShibaNoteTheme.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Manual Actions
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manual actions',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ShibaNoteTheme.foregroundColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // View Trash Button
                          SizedBox(
                            width: double.infinity,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const TrashScreen(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ShibaNoteTheme.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        size: 16,
                                        color: ShibaNoteTheme.foregroundColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'View trash',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: ShibaNoteTheme.foregroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Empty Trash Button
                          SizedBox(
                            width: double.infinity,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // Show confirmation dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Empty trash?'),
                                      content: const Text('This will permanently delete all notes in trash. This action cannot be undone.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Trash emptied')),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: ShibaNoteTheme.destructiveColor,
                                          ),
                                          child: const Text('Empty'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ShibaNoteTheme.borderColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete_outline,
                                        size: 16,
                                        color: ShibaNoteTheme.destructiveColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Empty trash now',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: ShibaNoteTheme.destructiveColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class CleanupOption {
  final String value;
  final String label;

  const CleanupOption({
    required this.value,
    required this.label,
  });
}
