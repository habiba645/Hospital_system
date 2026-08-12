// features/doctors/presentation/widgets/doctor_card.dart
import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/doctors/models/model.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_status_chip.dart';

class DoctorCard extends StatelessWidget {
  final DoctorModel doctor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onEdit,
  });

  DoctorAvailability get _status => doctor.workingDays.isEmpty
      ? DoctorAvailability.onLeave
      : DoctorAvailability.available;

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
              BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DoctorAvatar(name: doctor.fullName),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor.fullName,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(doctor.specialization,
                            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    tooltip: 'Edit doctor',
                    icon: const Icon(Icons.more_horiz_rounded, color: AppColors.textTertiary),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _MetaRow(icon: Icons.apartment_outlined, label: departmentNameForId(doctor.deptId)),
              const SizedBox(height: 8),
              _MetaRow(icon: Icons.schedule_outlined, label: doctor.workingHoursLabel),
              const SizedBox(height: 8),
              _MetaRow(icon: Icons.email_outlined, label: doctor.email),
              const SizedBox(height: 8),
              _MetaRow(icon: Icons.payments_outlined, label: '${doctor.consultationFee} EGP / visit'),
              const Spacer(),
              const SizedBox(height: 16),
              Row(
                children: [
                  DoctorStatusChip(status: _status),
                  const Spacer(),
                  TextButton(onPressed: onTap, child: const Text('View profile')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorAvatar extends StatelessWidget {
  final String name;
  const _DoctorAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      child: Text(
        _initials(name),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
      ),
    );
  }

  String _initials(String value) {
    final parts = value.replaceFirst(RegExp(r'^Dr\.?\s*', caseSensitive: false), '').trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
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
          child: Text(label,
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
              maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}