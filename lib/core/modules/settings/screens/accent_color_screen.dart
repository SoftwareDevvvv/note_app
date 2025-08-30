import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class AccentColorScreen extends StatefulWidget {
  const AccentColorScreen({Key? key}) : super(key: key);

  @override
  State<AccentColorScreen> createState() => _AccentColorScreenState();
}

class _AccentColorScreenState extends State<AccentColorScreen> {
  String selectedColor = "orange";

  final List<ColorOption> colorOptions = [
    ColorOption(
      id: "orange",
      name: "Shiba Orange",
      description: "Default warm orange",
      color: const Color(0xFFFFA238), // hsl(35, 100%, 62%)
    ),
    ColorOption(
      id: "coral",
      name: "Coral Pink",
      description: "Soft coral warmth",
      color: const Color(0xFFFF7A5C), // hsl(15, 85%, 65%)
    ),
    ColorOption(
      id: "peach",
      name: "Peach Cream",
      description: "Gentle peach tone",
      color: const Color(0xFFFFB085), // hsl(25, 90%, 70%)
    ),
    ColorOption(
      id: "golden",
      name: "Golden Honey",
      description: "Rich golden hue",
      color: const Color(0xFFE6B84D), // hsl(45, 85%, 60%)
    ),
    ColorOption(
      id: "amber",
      name: "Amber Glow",
      description: "Warm amber light",
      color: const Color(0xFFF5A623), // hsl(40, 95%, 58%)
    ),
  ];

  void handleSave() {
    // TODO: Implement color saving logic
    print("Saving color: $selectedColor");
    Navigator.of(context).pop();
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
                          'Accent Color',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: ShibaNoteTheme.foregroundColor,
                            letterSpacing: -0.25,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Choose your Shiba palette',
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

                    // Color Options
                    Column(
                      children: colorOptions.map((option) {
                        final isSelected = selectedColor == option.id;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedColor = option.id;
                                });
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: ShibaNoteTheme.cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelected 
                                        ? option.color 
                                        : ShibaNoteTheme.borderColor.withOpacity(0.5),
                                    width: isSelected ? 2 : 1,
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
                                    // Color Preview Circle
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: option.color,
                                        borderRadius: BorderRadius.circular(24),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: option.color.withOpacity(0.3),
                                            offset: const Offset(0, 2),
                                            blurRadius: 8,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 24,
                                            )
                                          : null,
                                    ),

                                    const SizedBox(width: 16),

                                    // Color Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: isSelected 
                                                  ? option.color 
                                                  : ShibaNoteTheme.foregroundColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            option.description,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: ShibaNoteTheme.mutedForeground,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Selection Indicator
                                    if (isSelected)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: option.color.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'Selected',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: option.color,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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

class ColorOption {
  final String id;
  final String name;
  final String description;
  final Color color;

  const ColorOption({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });
}
