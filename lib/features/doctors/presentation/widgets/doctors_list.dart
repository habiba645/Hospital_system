// features/doctors/presentation/widgets/doctors_list.dart
import 'package:flutter/material.dart';
import 'package:medidesk_app/features/doctors/models/model.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_card.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/empty_doctors_state.dart';

class DoctorsList extends StatelessWidget {
  final List<DoctorModel> doctors;
  final ValueChanged<DoctorModel>? onDoctorTap;
  final ValueChanged<DoctorModel>? onDoctorEdit;

  const DoctorsList({
    super.key,
    required this.doctors,
    this.onDoctorTap,
    this.onDoctorEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return const EmptyDoctorsState();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 1200 ? 3 : width >= 760 ? 2 : 1;
        const spacing = 16.0;
        final itemWidth = (width - spacing * (crossAxisCount - 1)) / crossAxisCount;

        return SingleChildScrollView(
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: doctors
                .map(
                  (doctor) => SizedBox(
                    width: itemWidth,
                    height: 280,
                    child: DoctorCard(
                      doctor: doctor,
                      onTap: onDoctorTap == null ? null : () => onDoctorTap!(doctor),
                      onEdit: onDoctorEdit == null ? null : () => onDoctorEdit!(doctor),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}