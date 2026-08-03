import 'package:flutter/material.dart';
import 'package:medidesk_app/core/routes/app_router.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class _NavItem {
  final String label;
  final IconData icon;
  final String path;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.path,
  });
}

class AppSidebar extends StatelessWidget {
  final UserRole role;
  final String currentPath;
  final ValueChanged<String> onNavigate;

  const AppSidebar({
    super.key,
    required this.role,
    required this.currentPath,
    required this.onNavigate,
  });

  List<_NavItem> get _items {
    if (role == UserRole.admin) {
      return const [
        _NavItem(label: 'Dashboard', icon: Icons.grid_view_rounded, path: '/admin'),
        _NavItem(label: 'Doctors', icon: Icons.medical_services_outlined, path: '/admin/doctors'),
        _NavItem(label: 'Departments', icon: Icons.apartment_outlined, path: '/admin/departments'),
        _NavItem(label: 'Receptionists', icon: Icons.people_outline, path: '/admin/receptionists'),
      ];
    }
    return const [
      _NavItem(label: 'Dashboard', icon: Icons.grid_view_rounded, path: '/reception'),
      _NavItem(label: 'Patients', icon: Icons.person_outline, path: '/reception/patients'),
      _NavItem(label: 'Appointments', icon: Icons.calendar_today_outlined, path: '/reception/appointments'),
      _NavItem(label: "Today's Schedule", icon: Icons.today_outlined, path: '/reception/today'),
      _NavItem(label: 'Weekly Schedule', icon: Icons.date_range_outlined, path: '/reception/weekly'),
    ];
  }

  bool _isActive(String path) {
    if (path == '/admin' || path == '/reception') {
      return currentPath == path;
    }
    return currentPath.startsWith(path);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
        border: Border(
          right: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MediDesk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      role == UserRole.admin ? 'Admin Console' : 'Reception',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Menu label
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textTertiary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Nav items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final active = _isActive(item.path);
                return _SidebarTile(
                  item: item,
                  isActive: active,
                  onTap: () => onNavigate(item.path),
                );
              },
            ),
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.all(12),
            child: _SidebarTile(
              item: const _NavItem(
                label: 'Logout',
                icon: Icons.logout_rounded,
                path: '/login',
              ),
              isActive: false,
              onTap: () {
                // TODO: call AuthCubit.logout() then navigate
                onNavigate('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isActive ? AppColors.sidebarActive : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          hoverColor: AppColors.sidebarHover,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: isActive
                      ? AppColors.sidebarIconActive
                      : AppColors.sidebarIcon,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive
                          ? AppColors.sidebarIconActive
                          : AppColors.textPrimary,
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
