import 'package:flutter/material.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/empty_receptionists_state.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_card.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_status_chip.dart';

class ReceptionistsList extends StatelessWidget {
  final List<ReceptionistCardData> receptionists;
  final ValueChanged<ReceptionistCardData>? onReceptionistTap;
  final ValueChanged<ReceptionistCardData>? onReceptionistEdit;

  const ReceptionistsList({
    super.key,
    required this.receptionists,
    this.onReceptionistTap,
    this.onReceptionistEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (receptionists.isEmpty) {
      return const EmptyReceptionistsState();
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
            children: receptionists
                .map(
                  (receptionist) => SizedBox(
                    width: itemWidth,
                    height: 260,
                    child: ReceptionistCard(
                      receptionist: receptionist,
                      onTap: onReceptionistTap == null
                          ? null
                          : () => onReceptionistTap!(receptionist),
                      onEdit: onReceptionistEdit == null
                          ? null
                          : () => onReceptionistEdit!(receptionist),
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

/// Sample receptionists used until the receptionists API is connected.
List<ReceptionistCardData> get sampleReceptionists => const [
      ReceptionistCardData(
        id: '1',
        name: 'Anna Martinez',
        email: 'anna.martinez@hospital.org',
        phone: '+1 (555) 301-2244',
        shiftHours: 'Mon–Fri · 07:00–15:00',
        assignedDesk: 'Main Lobby · Desk A',
        status: ReceptionistStatus.active,
      ),
      ReceptionistCardData(
        id: '2',
        name: 'Kevin O\'Brien',
        email: 'kevin.obrien@hospital.org',
        phone: '+1 (555) 301-2245',
        shiftHours: 'Mon–Fri · 15:00–23:00',
        assignedDesk: 'Main Lobby · Desk B',
        status: ReceptionistStatus.active,
      ),
      ReceptionistCardData(
        id: '3',
        name: 'Priya Sharma',
        email: 'priya.sharma@hospital.org',
        phone: '+1 (555) 301-2246',
        shiftHours: 'Tue–Sat · 09:00–17:00',
        assignedDesk: 'Emergency · Desk 1',
        status: ReceptionistStatus.onBreak,
      ),
      ReceptionistCardData(
        id: '4',
        name: 'Marcus Johnson',
        email: 'marcus.j@hospital.org',
        phone: '+1 (555) 301-2247',
        shiftHours: 'Wed–Sun · 11:00–19:00',
        assignedDesk: 'Outpatient · Desk 2',
        status: ReceptionistStatus.active,
      ),
      ReceptionistCardData(
        id: '5',
        name: 'Yuki Tanaka',
        email: 'yuki.tanaka@hospital.org',
        phone: '+1 (555) 301-2248',
        shiftHours: 'Mon–Thu · 08:00–16:00',
        assignedDesk: 'Pediatrics · Desk 1',
        status: ReceptionistStatus.inactive,
      ),
      ReceptionistCardData(
        id: '6',
        name: 'Fatima Al-Hassan',
        email: 'fatima.alhassan@hospital.org',
        phone: '+1 (555) 301-2249',
        shiftHours: 'Mon–Fri · 07:00–15:00',
        assignedDesk: 'Main Lobby · Desk C',
        status: ReceptionistStatus.active,
      ),
    ];
