class DepartmentModel {
  final int? id;
  final String name;
  final String description;

  DepartmentModel({
    this.id,
    required this.name,
    required this.description,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['dept_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}