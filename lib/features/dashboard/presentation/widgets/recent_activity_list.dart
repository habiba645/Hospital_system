import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';

class ActivityItemData {
  final String title;
  final String subtitle;
  final String timeLabel;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  const ActivityItemData({
    required this.title,
    required this.subtitle,
    required this.timeLabel,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });
}

class RecentActivityItem extends StatelessWidget {
  final ActivityItemData item;
  final bool showDivider;

  const RecentActivityItem({
    super.key,
    required this.item,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: item.iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, size: 18, color: item.iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.timeLabel,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1),
      ],
    );
  }
}

class RecentActivityList extends StatelessWidget {
  final List<ActivityItemData> items;

  const RecentActivityList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No recent activity',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          RecentActivityItem(
            item: items[i],
            showDivider: i < items.length - 1,
          ),
      ],
    );
  }
}

List<ActivityItemData> get defaultRecentActivities => const [
      ActivityItemData(
        title: 'New doctor registered',
        subtitle: 'Dr. Sarah Chen joined Cardiology',
        timeLabel: '12m ago',
        icon: Icons.person_add_alt_1_outlined,
        iconColor: AppColors.primary,
        iconBackground: AppColors.sidebarActive,
      ),
      ActivityItemData(
        title: 'Department updated',
        subtitle: 'Neurology schedule hours changed',
        timeLabel: '1h ago',
        icon: Icons.apartment_outlined,
        iconColor: AppColors.secondary,
        iconBackground: AppColors.departmentChip,
      ),
      ActivityItemData(
        title: 'Receptionist assigned',
        subtitle: 'Emma Wilson → Front Desk A',
        timeLabel: '2h ago',
        icon: Icons.badge_outlined,
        iconColor: AppColors.info,
        iconBackground: AppColors.infoBg,
      ),
      ActivityItemData(
        title: 'Appointment spike',
        subtitle: 'Pediatrics booked 24 slots today',
        timeLabel: '3h ago',
        icon: Icons.trending_up_rounded,
        iconColor: AppColors.warning,
        iconBackground: AppColors.warningBg,
      ),
    ];

/// Default front-desk activity feed used by the reception dashboard screen.
List<ActivityItemData> get defaultReceptionActivities => const [
      ActivityItemData(
        title: 'Patient checked in',
        subtitle: 'James Wilson → Cardiology · Dr. Nora Patel',
        timeLabel: '5m ago',
        icon: Icons.how_to_reg_outlined,
        iconColor: AppColors.success,
        iconBackground: AppColors.successBg,
      ),
      ActivityItemData(
        title: 'New patient registered',
        subtitle: 'Emma Clarke added to the system',
        timeLabel: '18m ago',
        icon: Icons.person_add_alt_1_outlined,
        iconColor: AppColors.primary,
        iconBackground: AppColors.sidebarActive,
      ),
      ActivityItemData(
        title: 'Appointment rescheduled',
        subtitle: 'Mia Thompson moved to 11:30 · Pediatrics',
        timeLabel: '42m ago',
        icon: Icons.event_repeat_outlined,
        iconColor: AppColors.secondary,
        iconBackground: AppColors.departmentChip,
      ),
      ActivityItemData(
        title: 'Walk-in added',
        subtitle: 'Omar Hassan queued for Dermatology',
        timeLabel: '1h ago',
        icon: Icons.directions_walk_outlined,
        iconColor: AppColors.info,
        iconBackground: AppColors.infoBg,
      ),
    ];
