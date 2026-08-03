import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medidesk_app/core/routes/app_router.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/core/widgets/app_sidebar.dart';
import 'package:medidesk_app/core/widgets/app_top_bar.dart';

/// Main layout shell that hosts the sidebar + top bar + content area.
/// Used by both Admin and Reception roles.
class AppShell extends StatelessWidget {
  final UserRole role;
  final String currentPath;
  final Widget child;

  const AppShell({
    super.key,
    required this.role,
    required this.currentPath,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // ── Sidebar ───────────────────────────────────────
          AppSidebar(
            role: role,
            currentPath: currentPath,
            onNavigate: (path) => context.go(path),
          ),

          // ── Main content ──────────────────────────────────
          Expanded(
            child: Column(
              children: [
                AppTopBar(role: role),
                Expanded(
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
