import 'package:flutter/material.dart';
import 'package:medidesk_app/features/schedule/data/models/schedule_models.dart';

/// Small event block placed on the weekly grid representing one appointment.
class WeeklyAppointmentCard extends StatelessWidget {
  final WeeklyAppointment appointment;

  const WeeklyAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: appointment.status.backgroundColor,
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: appointment.status.color, width: 3)),
      ),
      alignment: Alignment.topLeft,
     
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appointment.patientName,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: appointment.status.color,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              appointment.doctorName,
              style: TextStyle(
                fontSize: 9.5,
                color: appointment.status.color.withOpacity(0.85),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}