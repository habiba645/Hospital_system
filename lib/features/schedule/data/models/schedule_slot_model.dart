class ScheduleSlotModel {
  final int? id;
  final int? doctorId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int? slotDurationMinutes;

  ScheduleSlotModel({
    this.id,
    this.doctorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.slotDurationMinutes,
  });

  factory ScheduleSlotModel.fromJson(Map<String, dynamic> json) {
    return ScheduleSlotModel(
      id: json['id'],
      doctorId: json['doctor_id'],
      dayOfWeek: json['day_of_week'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      slotDurationMinutes: json['slot_duration_minutes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_of_week': dayOfWeek,
      'start_time': startTime,
      'end_time': endTime,
      if (slotDurationMinutes != null)
        'slot_duration_minutes': slotDurationMinutes,
    };
  }
}