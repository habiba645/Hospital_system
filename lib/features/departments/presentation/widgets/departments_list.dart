import 'package:flutter/material.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_card.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/department_status_chip.dart';
import 'package:medidesk_app/features/departments/presentation/widgets/empty_departments_state.dart';

class DepartmentsList extends StatelessWidget {
  final List<DepartmentCardData> departments;
  final ValueChanged<DepartmentCardData>? onDepartmentTap;
  final ValueChanged<DepartmentCardData>? onDepartmentEdit;

  const DepartmentsList({
    super.key,
    required this.departments,
    this.onDepartmentTap,
    this.onDepartmentEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (departments.isEmpty) {
      return const EmptyDepartmentsState();
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
            children: departments
                .map(
                  (department) => SizedBox(
                    width: itemWidth,
                    height: 280,
                    child: DepartmentCard(
                      department: department,
                      onTap: onDepartmentTap == null
                          ? null
                          : () => onDepartmentTap!(department),
                      onEdit: onDepartmentEdit == null
                          ? null
                          : () => onDepartmentEdit!(department),
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

/// Sample departments used until the departments API is connected.
List<DepartmentCardData> get sampleDepartments => const [
      DepartmentCardData(
        id: '1',
        name: 'Cardiology',
        description: 'Heart and cardiovascular care services.',
        headDoctor: 'Dr. Nora Patel',
        doctorCount: 8,
        activePatients: 214,
        status: DepartmentStatus.active,
      ),
      DepartmentCardData(
        id: '2',
        name: 'Pediatrics',
        description: 'Medical care for infants, children, and adolescents.',
        headDoctor: 'Dr. Liam Brooks',
        doctorCount: 6,
        activePatients: 186,
        status: DepartmentStatus.active,
      ),
      DepartmentCardData(
        id: '3',
        name: 'Neurology',
        description: 'Diagnosis and treatment of nervous system disorders.',
        headDoctor: 'Dr. Omar Farid',
        doctorCount: 5,
        activePatients: 142,
        status: DepartmentStatus.active,
      ),
      DepartmentCardData(
        id: '4',
        name: 'Orthopedics',
        description: 'Bone, joint, and musculoskeletal treatment.',
        headDoctor: 'Dr. Ethan Cole',
        doctorCount: 7,
        activePatients: 198,
        status: DepartmentStatus.active,
      ),
      DepartmentCardData(
        id: '5',
        name: 'Dermatology',
        description: 'Skin, hair, and nail conditions.',
        headDoctor: 'Dr. Ava Kim',
        doctorCount: 4,
        activePatients: 96,
        status: DepartmentStatus.active,
      ),
      DepartmentCardData(
        id: '6',
        name: 'Emergency',
        description: '24/7 acute and emergency medical services.',
        headDoctor: 'Dr. Rachel Nguyen',
        doctorCount: 12,
        activePatients: 448,
        status: DepartmentStatus.active,
      ),
    ];
