import 'package:flutter/material.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_card.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/doctor_status_chip.dart';
import 'package:medidesk_app/features/doctors/presentation/widgets/empty_doctors_state.dart';

class DoctorsList extends StatelessWidget {
  final List<DoctorCardData> doctors;
  final ValueChanged<DoctorCardData>? onDoctorTap;
  final ValueChanged<DoctorCardData>? onDoctorEdit;

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
        final crossAxisCount = width >= 1200
            ? 3
            : width >= 760
                ? 2
                : 1;
        const spacing = 16.0;
        final itemWidth =
            (width - spacing * (crossAxisCount - 1)) / crossAxisCount;

        return SingleChildScrollView(
          child: Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: doctors
                .map(
                  (doctor) => SizedBox(
                    width: itemWidth,
                    height: 260,
                    child: DoctorCard(
                      doctor: doctor,
                      onTap: onDoctorTap == null
                          ? null
                          : () => onDoctorTap!(doctor),
                      onEdit: onDoctorEdit == null
                          ? null
                          : () => onDoctorEdit!(doctor),
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

/// Sample doctors used until the doctors API is connected.
List<DoctorCardData> get sampleDoctors => const [
      DoctorCardData(
        id: '1',
        name: 'Dr. Nora Patel',
        specialty: 'Interventional Cardiology',
        department: 'Cardiology',
        workingHours: 'Mon–Fri · 09:00–17:00',
        email: 'nora.patel@hospital.org',
        status: DoctorAvailability.available,
      ),
      DoctorCardData(
        id: '2',
        name: 'Dr. Liam Brooks',
        specialty: 'Pediatric Medicine',
        department: 'Pediatrics',
        workingHours: 'Mon–Thu · 08:00–16:00',
        email: 'liam.brooks@hospital.org',
        status: DoctorAvailability.busy,
      ),
      DoctorCardData(
        id: '3',
        name: 'Dr. Ava Kim',
        specialty: 'Clinical Dermatology',
        department: 'Dermatology',
        workingHours: 'Tue–Sat · 10:00–18:00',
        email: 'ava.kim@hospital.org',
        status: DoctorAvailability.available,
      ),
      DoctorCardData(
        id: '4',
        name: 'Dr. Ethan Cole',
        specialty: 'Orthopedic Surgery',
        department: 'Orthopedics',
        workingHours: 'Mon–Wed · 07:30–15:30',
        email: 'ethan.cole@hospital.org',
        status: DoctorAvailability.onLeave,
      ),
      DoctorCardData(
        id: '5',
        name: 'Dr. Sarah Chen',
        specialty: 'Cardiac Imaging',
        department: 'Cardiology',
        workingHours: 'Mon–Fri · 09:00–15:00',
        email: 'sarah.chen@hospital.org',
        status: DoctorAvailability.available,
      ),
      DoctorCardData(
        id: '6',
        name: 'Dr. Omar Farid',
        specialty: 'Neurology',
        department: 'Neurology',
        workingHours: 'Wed–Fri · 11:00–19:00',
        email: 'omar.farid@hospital.org',
        status: DoctorAvailability.busy,
      ),
    ];
