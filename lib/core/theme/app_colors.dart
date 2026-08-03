import 'package:flutter/material.dart';

/// MediDesk color palette matching the design system from the UI mockups.
class AppColors {
  // Brand
  static const Color primary = Color(0xFF0D9488); // Teal / Primary CTA
  static const Color primaryDark = Color(0xFF0F766E);
  static const Color primaryLight = Color(0xFF14B8A6);
  static const Color secondary = Color(0xFF0EA5E9);

  // Backgrounds
  static const Color background = Color(0xFFF0FDFA); // Soft mint tint
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color sidebar = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Colors.white;

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color successBg = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningBg = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoBg = Color(0xFFDBEAFE);

  // Appointment status chips
  static const Color upcoming = Color(0xFF0EA5E9);
  static const Color upcomingBg = Color(0xFFE0F2FE);
  static const Color completed = Color(0xFF10B981);
  static const Color completedBg = Color(0xFFD1FAE5);
  static const Color cancelled = Color(0xFFEF4444);
  static const Color cancelledBg = Color(0xFFFEE2E2);

  // Chips / Tags
  static const Color chipBackground = Color(0xFFF1F5F9);
  static const Color departmentChip = Color(0xFFE0F2FE);

  // Sidebar
  static const Color sidebarActive = Color(0xFFCCFBF1);
  static const Color sidebarHover = Color(0xFFF0FDFA);
  static const Color sidebarIcon = Color(0xFF64748B);
  static const Color sidebarIconActive = Color(0xFF0D9488);

  // Shadows / overlays
  static const Color overlay = Color(0x80000000);
  static const Color shadow = Color(0x1A000000);
}
