import 'package:flutter/material.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_card.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionist_status_chip.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionists_header.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionists_list.dart';
import 'package:medidesk_app/features/receptionists/presentation/widgets/receptionists_toolbar.dart';

class ReceptionistsScreen extends StatefulWidget {
  const ReceptionistsScreen({super.key});

  @override
  State<ReceptionistsScreen> createState() => _ReceptionistsScreenState();
}

class _ReceptionistsScreenState extends State<ReceptionistsScreen> {
  static const _allFilter = 'All';

  final _searchController = TextEditingController();
  late final List<ReceptionistCardData> _allReceptionists;
  late final List<String> _filterOptions;

  String _query = '';
  String _selectedFilter = _allFilter;

  @override
  void initState() {
    super.initState();
    _allReceptionists = sampleReceptionists;
    _filterOptions = [
      _allFilter,
      'Active',
      'Inactive',
      'On Break',
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReceptionistCardData> get _filteredReceptionists {
    final query = _query.trim().toLowerCase();
    return _allReceptionists.where((receptionist) {
      final matchesFilter = _selectedFilter == _allFilter ||
          _statusLabel(receptionist.status) == _selectedFilter;
      if (!matchesFilter) return false;
      if (query.isEmpty) return true;
      return receptionist.name.toLowerCase().contains(query) ||
          receptionist.assignedDesk.toLowerCase().contains(query) ||
          receptionist.email.toLowerCase().contains(query);
    }).toList();
  }

  String _statusLabel(ReceptionistStatus status) => switch (status) {
        ReceptionistStatus.active => 'Active',
        ReceptionistStatus.inactive => 'Inactive',
        ReceptionistStatus.onBreak => 'On Break',
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReceptionistsHeader(onAddReceptionist: () {}),
          const SizedBox(height: 24),
          ReceptionistsToolbar(
            searchController: _searchController,
            onSearchChanged: (value) => setState(() => _query = value),
            filterOptions: _filterOptions,
            selectedFilter: _selectedFilter,
            onFilterSelected: (value) =>
                setState(() => _selectedFilter = value),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ReceptionistsList(
              receptionists: _filteredReceptionists,
              onReceptionistTap: (_) {},
              onReceptionistEdit: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
