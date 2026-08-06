import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_status_chip.dart';

class PatientCardData {
  final String id;
  final String name;
  final String ageGender;
  final String phone;
  final String email;
  final String lastVisit;
  final PatientStatus status;

  const PatientCardData({
    required this.id,
    required this.name,
    required this.ageGender,
    required this.phone,
    required this.email,
    required this.lastVisit,
    required this.status,
  });
}

class PatientCard extends StatelessWidget {
  final PatientCardData patient;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const PatientCard({
    super.key,
    required this.patient,
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
                  _PatientAvatar(name: patient.name),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.name,
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
                          patient.ageGender,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    tooltip: 'Edit patient',
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
                icon: Icons.phone_outlined,
                label: patient.phone,
              ),
              const SizedBox(height: 8),
              _MetaRow(
                icon: Icons.email_outlined,
                label: patient.email,
              ),
              const SizedBox(height: 8),
              _MetaRow(
                icon: Icons.event_outlined,
                label: 'Last visit · ${patient.lastVisit}',
              ),
              const Spacer(),
              const SizedBox(height: 16),
              Row(
                children: [
                  PatientStatusChip(status: patient.status),
                  const Spacer(),
                  TextButton(
                    onPressed: onTap,
                    child: const Text('View record'),
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

class _PatientAvatar extends StatelessWidget {
  final String name;

  const _PatientAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.secondary.withValues(alpha: 0.15),
      child: Text(
        _initials(name),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  String _initials(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
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
