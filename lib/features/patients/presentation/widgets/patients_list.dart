import 'package:flutter/material.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/empty_patients_state.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_card.dart';
import 'package:medidesk_app/features/patients/presentation/widgets/patient_status_chip.dart';

class PatientsList extends StatelessWidget {
  final List<PatientCardData> patients;
  final ValueChanged<PatientCardData>? onPatientTap;
  final ValueChanged<PatientCardData>? onPatientEdit;

  const PatientsList({
    super.key,
    required this.patients,
    this.onPatientTap,
    this.onPatientEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return const EmptyPatientsState();
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
            children: patients
                .map(
                  (patient) => SizedBox(
                    width: itemWidth,
                    height: 260,
                    child: PatientCard(
                      patient: patient,
                      onTap: onPatientTap == null
                          ? null
                          : () => onPatientTap!(patient),
                      onEdit: onPatientEdit == null
                          ? null
                          : () => onPatientEdit!(patient),
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

/// Sample patients used until the patients API is connected.
List<PatientCardData> get samplePatients => const [
      PatientCardData(
        id: '1',
        name: 'James Wilson',
        ageGender: '42 · Male',
        phone: '+1 (555) 234-8901',
        email: 'james.wilson@email.com',
        lastVisit: 'Aug 2, 2026',
        status: PatientStatus.active,
      ),
      PatientCardData(
        id: '2',
        name: 'Emily Rodriguez',
        ageGender: '29 · Female',
        phone: '+1 (555) 876-5432',
        email: 'emily.r@email.com',
        lastVisit: 'Jul 28, 2026',
        status: PatientStatus.active,
      ),
      PatientCardData(
        id: '3',
        name: 'Michael Chen',
        ageGender: '55 · Male',
        phone: '+1 (555) 112-3344',
        email: 'm.chen@email.com',
        lastVisit: 'Jun 15, 2026',
        status: PatientStatus.inactive,
      ),
      PatientCardData(
        id: '4',
        name: 'Sarah Thompson',
        ageGender: '33 · Female',
        phone: '+1 (555) 998-7766',
        email: 'sarah.t@email.com',
        lastVisit: 'Aug 5, 2026',
        status: PatientStatus.newPatient,
      ),
      PatientCardData(
        id: '5',
        name: 'David Okonkwo',
        ageGender: '61 · Male',
        phone: '+1 (555) 445-6677',
        email: 'd.okonkwo@email.com',
        lastVisit: 'Jul 30, 2026',
        status: PatientStatus.active,
      ),
      PatientCardData(
        id: '6',
        name: 'Lisa Park',
        ageGender: '27 · Female',
        phone: '+1 (555) 223-8899',
        email: 'lisa.park@email.com',
        lastVisit: 'May 10, 2026',
        status: PatientStatus.inactive,
      ),
    ];
