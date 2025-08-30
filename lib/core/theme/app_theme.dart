import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';  // Removed - causing JDK build issues

// ShibaNote Theme Configuration - Based on index.css specifications
class ShibaNoteTheme {
  // Brand Colors - Exact HSL to RGB conversion matching CSS
  static const Color backgroundColor =
      Color(0xFFFAF7F2); // hsl(40 50% 96%) - verified
  static const Color foregroundColor =
      Color(0xFF3A2F2F); // hsl(0 14% 21%) - exact CSS match
  static const Color cardColor =
      Color(0xFFFCFAF7); // hsl(40 50% 98%) - exact CSS match
  static const Color cardForeground = Color(0xFF3A2F2F); // hsl(0 14% 21%)

  // Primary Orange - Shiba Inu warmth
  static const Color primaryColor = Color(0xFFFFA238); // hsl(35 100% 62%)
  static const Color primaryForeground = Color(0xFFFAF7F2); // hsl(40 50% 96%)

  // Warm secondary tones
  static const Color secondaryColor =
      Color(0xFFF5E6C8); // hsl(35 80% 85%) - more accurate
  static const Color secondaryForeground = Color(0xFF362E2A); // hsl(0 14% 21%)

  // Soft muted tones
  static const Color mutedColor =
      Color(0xFFF2EFEA); // hsl(40 30% 90%) - more accurate
  static const Color mutedForeground =
      Color(0xFF736B63); // hsl(0 14% 45%) - exact CSS match

  // Accent for highlights
  static const Color accentColor = Color(0xFFE6CCA3); // hsl(35 60% 75%)
  static const Color accentForeground =
      Color(0xFF3A2F2F); // hsl(0 14% 21%) - exact CSS match

  // Soft borders and inputs - More accurate conversion
  static const Color borderColor =
      Color(0xFFE8D6BC); // hsl(35 30% 85%) - more accurate
  static const Color inputColor =
      Color(0xFFE5D3B7); // hsl(35 30% 88%) - more accurate

  // Pastel Tag Colors - Converted from HSL
  static const Color tagPink = Color(0xFFF2D7E0); // hsl(330 50% 85%)
  static const Color tagPinkForeground = Color(0xFF804D5C); // hsl(330 30% 35%)
  static const Color tagBlue = Color(0xFFD7E8F2); // hsl(210 50% 85%)
  static const Color tagBlueForeground = Color(0xFF4D6680); // hsl(210 50% 35%)
  static const Color tagGreen = Color(0xFFE0F2D7); // hsl(120 40% 85%)
  static const Color tagGreenForeground = Color(0xFF5C804D); // hsl(120 40% 35%)
  static const Color tagPurple = Color(0xFFE8D7F2); // hsl(270 50% 85%)
  static const Color tagPurpleForeground =
      Color(0xFF664D80); // hsl(270 40% 35%)
  static const Color tagYellow = Color(0xFFF2ECD7); // hsl(50 60% 85%)
  static const Color tagYellowForeground = Color(0xFF807A4D); // hsl(50 60% 35%)

  // Text Colors - Updated to use exact CSS matches
  static const Color textPrimary = foregroundColor; // #3A2F2F
  static const Color textSecondary = mutedForeground; // #736B63
  static const Color textLight =
      Color(0xFF9C9186); // Lighter shade for subtle text

  // Destructive
  static const Color destructiveColor = Color(0xFFE57373); // hsl(0 70% 65%)
  static const Color destructiveForeground =
      Color(0xFFFAF7F2); // hsl(40 50% 96%)

  // Shadow Colors - matching CSS shadow specifications
  static const Color shadowSoft = Color(0x4DD4C4A3); // hsl(35 20% 80% / 0.3)
  static const Color shadowHover = Color(0x66B8A082); // hsl(35 40% 70% / 0.4)

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // Set Nunito as the default font family for the entire app
      fontFamily: 'Nunito',
      // Explicitly set scaffold background color to match CSS --background: 40 50% 96%
      scaffoldBackgroundColor: backgroundColor, // #FAF7F2 cream background
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: primaryForeground,
        secondary: secondaryColor,
        onSecondary: secondaryForeground,
        tertiary: accentColor,
        onTertiary: accentForeground,
        error: destructiveColor,
        onError: destructiveForeground,
        surface: cardColor,
        onSurface: cardForeground,
        surfaceVariant: mutedColor,
        onSurfaceVariant: mutedForeground,
        outline: borderColor,
        shadow: const Color(0x4DD4C4A3), // hsl(35 20% 80% / 0.3) shadow-soft
      ),

      // Typography - Nunito Font Family (matching body font-sans from CSS)
      textTheme: const TextTheme(
        // Heading 1 - Nunito Bold (larger for h1)
        headlineLarge: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 36, // Increased from 32
          color: textPrimary,
          letterSpacing: -0.6,
        ),
        // Heading 2 - Nunito Semibold
        headlineMedium: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w600,
          fontSize: 28, // Increased from 24
          color: textPrimary,
          letterSpacing: -0.4,
        ),
        // Heading 3 - Nunito Medium
        headlineSmall: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize: 22, // Increased from 20
          color: textPrimary,
          letterSpacing: -0.2,
        ),
        // Body Text - Nunito Regular (standard web body size)
        bodyLarge: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: textPrimary,
          letterSpacing: 0.15,
          height: 1.6, // Improved line height
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: textPrimary,
          letterSpacing: 0.25,
          height: 1.5,
        ),
        // Small Text - Nunito Regular
        bodySmall: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: textSecondary,
          letterSpacing: 0.4,
          height: 1.4,
        ),
        // Labels
        labelLarge: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: textPrimary,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: textSecondary,
          letterSpacing: 0.5,
        ),
      ),

      // Card Theme with soft shadows - matching CSS shadow specifications
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2, // Adding subtle elevation to match CSS shadow-soft
        shadowColor: shadowSoft, // Using defined shadow color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // --radius: 1rem
          // Removing border as CSS cards don't have borders by default
        ),
        margin: EdgeInsets.zero,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: textPrimary,
          letterSpacing: -0.25,
        ),
        iconTheme: const IconThemeData(
          color: textPrimary,
          size: 24,
        ),
      ),

      // Elevated Button Theme (Primary)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: primaryForeground,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.hovered)) {
              return primaryForeground.withOpacity(0.08);
            }
            if (states.contains(MaterialState.pressed)) {
              return primaryForeground.withOpacity(0.16);
            }
            return null;
          }),
        ),
      ),

      // Outlined Button Theme (Secondary/Outline)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // Text Button Theme (Ghost)
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: textSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Nunito',
          color: textLight,
          fontSize: 14,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24,
      ),
    );
  }
}

// Custom Button Widgets with exact styling
class ShibaNoteButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isSmall;
  final Widget? icon;

  const ShibaNoteButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isSmall = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = isSmall ? 36.0 : 48.0;
    final fontSize = isSmall ? 14.0 : 16.0;
    final borderRadius = BorderRadius.circular(isSmall ? 12 : 16);

    final textStyle = TextStyle(
      fontFamily: 'Nunito',
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      letterSpacing: 0.1,
    );

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon!,
          const SizedBox(width: 8),
        ],
        Text(text, style: textStyle),
      ],
    );

    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ShibaNoteTheme.primaryColor,
              foregroundColor: ShibaNoteTheme.primaryForeground,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.secondary:
        return SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ShibaNoteTheme.secondaryColor,
              foregroundColor: ShibaNoteTheme.secondaryForeground,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.outline:
        return SizedBox(
          height: height,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: ShibaNoteTheme.textPrimary,
              side:
                  const BorderSide(color: ShibaNoteTheme.borderColor, width: 1),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: buttonChild,
          ),
        );

      case ButtonType.ghost:
        return SizedBox(
          height: height,
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: ShibaNoteTheme.textSecondary,
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: buttonChild,
          ),
        );
    }
  }
}

enum ButtonType { primary, secondary, outline, ghost }

// Custom Tag Widget with exact color specifications
class ShibaNoteTag extends StatelessWidget {
  final String text;
  final TagColor color;
  final VoidCallback? onTap;

  const ShibaNoteTag({
    Key? key,
    required this.text,
    this.color = TagColor.pink,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagColors = _getTagColors(color);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: tagColors.$1,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: tagColors.$2,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  (Color, Color) _getTagColors(TagColor color) {
    switch (color) {
      case TagColor.pink:
        return (ShibaNoteTheme.tagPink, ShibaNoteTheme.tagPinkForeground);
      case TagColor.blue:
        return (ShibaNoteTheme.tagBlue, ShibaNoteTheme.tagBlueForeground);
      case TagColor.green:
        return (ShibaNoteTheme.tagGreen, ShibaNoteTheme.tagGreenForeground);
      case TagColor.purple:
        return (ShibaNoteTheme.tagPurple, ShibaNoteTheme.tagPurpleForeground);
      case TagColor.yellow:
        return (ShibaNoteTheme.tagYellow, ShibaNoteTheme.tagYellowForeground);
    }
  }
}

enum TagColor { pink, blue, green, purple, yellow }

// Predefined tag colors matching CSS specifications
class TagColors {
  static const List<Color> backgroundColors = [
    ShibaNoteTheme.tagPink,
    ShibaNoteTheme.tagBlue,
    ShibaNoteTheme.tagGreen,
    ShibaNoteTheme.tagPurple,
    ShibaNoteTheme.tagYellow,
  ];

  static const List<Color> foregroundColors = [
    ShibaNoteTheme.tagPinkForeground,
    ShibaNoteTheme.tagBlueForeground,
    ShibaNoteTheme.tagGreenForeground,
    ShibaNoteTheme.tagPurpleForeground,
    ShibaNoteTheme.tagYellowForeground,
  ];

  static const List<String> names = [
    'Pink',
    'Blue',
    'Green',
    'Purple',
    'Yellow',
  ];

  static const List<TagColor> values = [
    TagColor.pink,
    TagColor.blue,
    TagColor.green,
    TagColor.purple,
    TagColor.yellow,
  ];

  static var colors;
}

// Custom ShibaNote Card Widget matching CSS specifications exactly
class ShibaNoteCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final bool hover;

  const ShibaNoteCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.hover = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: ShibaNoteTheme.cardColor,
        borderRadius: BorderRadius.circular(16), // --radius: 1rem
        boxShadow: [
          BoxShadow(
            color:
                hover ? ShibaNoteTheme.shadowHover : ShibaNoteTheme.shadowSoft,
            offset: hover ? const Offset(0, 4) : const Offset(0, 2),
            blurRadius: hover ? 20 : 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
