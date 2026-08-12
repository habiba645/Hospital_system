// features/doctors/presentation/widgets/doctorform.dart
import 'package:flutter/material.dart';
import 'package:medidesk_app/core/theme/app_colors.dart';
import 'package:medidesk_app/features/doctors/models/model.dart';

const _weekDays = [
  'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
];

/// Shows the add/edit doctor dialog. Returns the built DoctorModel, or null
/// if cancelled. Caller is responsible for calling the cubit.
Future<DoctorModel?> showDoctorFormDialog(
  BuildContext context, {
  DoctorModel? existing,
}) {
  return showDialog<DoctorModel>(
    context: context,
    builder: (_) => DoctorFormDialog(existing: existing),
  );
}

class DoctorFormDialog extends StatefulWidget {
  final DoctorModel? existing;
  const DoctorFormDialog({super.key, this.existing});

  @override
  State<DoctorFormDialog> createState() => _DoctorFormDialogState();
}

class _DoctorFormDialogState extends State<DoctorFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullName;
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _specialization;
  late final TextEditingController _fee;
  late final TextEditingController _password;
  late final TextEditingController _slotDuration;

  int? _deptId;
  final Map<String, TimeOfDay?> _dayStart = {};
  final Map<String, TimeOfDay?> _dayEnd = {};
  final Set<String> _selectedDays = {};

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final d = widget.existing;
    _fullName = TextEditingController(text: d?.fullName ?? '');
    _username = TextEditingController(text: d?.username ?? '');
    _email = TextEditingController(text: d?.email ?? '');
    _phone = TextEditingController(text: d?.phone ?? '');
    _specialization = TextEditingController(text: d?.specialization ?? '');
    _fee = TextEditingController(text: d?.consultationFee ?? '');
    _password = TextEditingController();
    _slotDuration =
        TextEditingController(text: d?.slotDurationMinutes?.toString() ?? '30');
    _deptId = d?.deptId ?? mockDepartments.first.id;

    for (final wd in d?.workingDays ?? []) {
      _selectedDays.add(wd.dayOfWeek);
      _dayStart[wd.dayOfWeek] = _parseTime(wd.startTime);
      _dayEnd[wd.dayOfWeek] = _parseTime(wd.endTime);
    }
  }

  TimeOfDay? _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return null;
    return TimeOfDay(hour: int.tryParse(parts[0]) ?? 0, minute: int.tryParse(parts[1]) ?? 0);
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:00';

  @override
  void dispose() {
    _fullName.dispose();
    _username.dispose();
    _email.dispose();
    _phone.dispose();
    _specialization.dispose();
    _fee.dispose();
    _password.dispose();
    _slotDuration.dispose();
    super.dispose();
  }

  Future<void> _pickTime(String day, {required bool isStart}) async {
    final initial = (isStart ? _dayStart[day] : _dayEnd[day]) ?? TimeOfDay.now();
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _dayStart[day] = picked;
      } else {
        _dayEnd[day] = picked;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final workingDays = _selectedDays.map((day) {
      final start = _dayStart[day] ?? const TimeOfDay(hour: 9, minute: 0);
      final end = _dayEnd[day] ?? const TimeOfDay(hour: 17, minute: 0);
      return DoctorWorkingDay(
        dayOfWeek: day,
        startTime: _formatTime(start),
        endTime: _formatTime(end),
      );
    }).toList();

    final doctor = DoctorModel(
      id: widget.existing?.id,
      username: _username.text.trim(),
      fullName: _fullName.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      deptId: _deptId,
      specialization: _specialization.text.trim(),
      consultationFee: _fee.text.trim(),
      workingDays: workingDays,
      slotDurationMinutes: int.tryParse(_slotDuration.text.trim()),
      password: _password.text.trim().isEmpty ? null : _password.text.trim(),
    );

    Navigator.of(context).pop(doctor);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Edit Doctor' : 'Add Doctor',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field(_fullName, 'Full name'),
                        _field(_username, 'Username'),
                        _field(_email, 'Email', keyboardType: TextInputType.emailAddress),
                        _field(_phone, 'Phone', keyboardType: TextInputType.phone),
                        _field(_specialization, 'Specialization'),
                        Row(
                          children: [
                            Expanded(child: _field(_fee, 'Consultation fee', keyboardType: TextInputType.number)),
                            const SizedBox(width: 12),
                            Expanded(child: _field(_slotDuration, 'Slot duration (min)', keyboardType: TextInputType.number)),
                          ],
                        ),
                        if (!_isEditing)
                          _field(_password, 'Password', obscure: true),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<int>(
                          initialValue: _deptId,
                          decoration: const InputDecoration(labelText: 'Department'),
                          items: mockDepartments
                              .map((d) => DropdownMenuItem(value: d.id, child: Text(d.name)))
                              .toList(),
                          onChanged: (v) => setState(() => _deptId = v),
                        ),
                        const SizedBox(height: 16),
                        const Text('Working days',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 8),
                        ..._weekDays.map(_dayRow),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isEditing ? 'Save changes' : 'Add doctor'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dayRow(String day) {
    final selected = _selectedDays.contains(day);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: CheckboxListTile(
              value: selected,
              onChanged: (v) => setState(() {
                if (v == true) {
                  _selectedDays.add(day);
                } else {
                  _selectedDays.remove(day);
                }
              }),
              title: Text(day, style: const TextStyle(fontSize: 13)),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          if (selected) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: () => _pickTime(day, isStart: true),
                child: Text(_dayStart[day]?.format(context) ?? 'Start'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () => _pickTime(day, isStart: false),
                child: Text(_dayEnd[day]?.format(context) ?? 'End'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        decoration: InputDecoration(labelText: label),
        validator: (v) {
          if (obscure) return null; // password optional on edit
          if (v == null || v.trim().isEmpty) return 'Required';
          return null;
        },
      ),
    );
  }
}