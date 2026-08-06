import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_status_chip.dart';

class DepartmentCardData {
  final String id;
  final String name;
  final String description;
  final String headDoctor;
  final int doctorCount;
  final int activePatients;
  final DepartmentStatus status;

  const DepartmentCardData({
    required this.id,
    required this.name,
    required this.description,
    required this.headDoctor,
    required this.doctorCount,
    required this.activePatients,
    required this.status,
  });
}

class DepartmentCard extends StatelessWidget {
  final DepartmentCardData department;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const DepartmentCard({
    super.key,
    required this.department,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        hoverColor: AppColors.sidebarHover,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DepartmentIcon(name: department.name),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          department.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    tooltip: 'Edit department',
                    icon: const Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.textTertiary,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _MetaRow(
                icon: Icons.person_outline,
                label: 'Head · ${department.headDoctor}',
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      icon: Icons.medical_services_outlined,
                      label: 'Doctors',
                      value: '${department.doctorCount}',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatTile(
                      icon: Icons.people_outline,
                      label: 'Patients',
                      value: '${department.activePatients}',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 16),
              Row(
                children: [
                  DepartmentStatusChip(status: department.status),
                  const Spacer(),
                  TextButton(
                    onPressed: onTap,
                    child: const Text('View details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DepartmentIcon extends StatelessWidget {
  final String name;

  const _DepartmentIcon({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.departmentChip,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        _iconForDepartment(name),
        size: 22,
        color: AppColors.secondary,
      ),
    );
  }

  IconData _iconForDepartment(String value) {
    final lower = value.toLowerCase();
    if (lower.contains('cardio')) return Icons.monitor_heart_outlined;
    if (lower.contains('pediatr')) return Icons.child_care_outlined;
    if (lower.contains('neuro')) return Icons.psychology_outlined;
    if (lower.contains('ortho')) return Icons.accessibility_new_outlined;
    if (lower.contains('derma')) return Icons.spa_outlined;
    if (lower.contains('emergency')) return Icons.local_hospital_outlined;
    return Icons.apartment_outlined;
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textTertiary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
