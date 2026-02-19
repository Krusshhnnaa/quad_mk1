import 'package:flutter/material.dart';

// Light Theme Gradient
const LinearGradient kLightGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFB3E5FC), // Light Blue
    Color(0xFFFFF9C4), // Light Yellow
    Color(0xFFFFCDD2), // Light Pink/Peach
  ],
);

// Dark Theme Gradient
const LinearGradient kDarkGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF004D7A), // Deep Blue
    Color(0xFF1B1B2F), // Navy
    Color(0xFF3A0CA3), // Deep Purple
  ],
);

// Gradient background container
class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const GradientBackground({
    super.key,
    required this.child,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? kDarkGradient : kLightGradient,
      ),
      child: child,
    );
  }
}

// Theme provider for toggling
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void switchTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}

/// TEXT STYLES

TextStyle getDynamicTitleStyle(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDark ? Colors.white : const Color(0xFF001F3F),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getDynamicBodyStyle(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDark ? Colors.white70 : Colors.black87,
    fontSize: 16,
  );
}

TextStyle getChatTitleStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDark ? const Color(0xFF001F3F) : Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}

TextStyle getChatSubtitleStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDark ? const Color(0xFF349BAA) : Colors.grey[300],
    fontSize: 14,
  );
}

TextStyle getChatTimeStyle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDark ? const Color(0xFF001F3F) : Colors.grey[300],
    fontSize: 12,
  );
}

// Custom theme toggle widget
class AnimatedThemeSwitch extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const AnimatedThemeSwitch({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? Colors.grey[800] : Colors.yellow[600],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Icon(
            isDark ? Icons.nightlight_round : Icons.wb_sunny,
            size: 20,
            color: isDark ? Colors.white : Colors.orange[800],
          ),
        ),
      ),
    );
  }
}
