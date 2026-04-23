class Organization {
  final int id;
  final String name;
  final String description;
  final String code;
  final DateTime createdDate;
  final DateTime updatedDate;

  Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.code,
    required this.createdDate,
    required this.updatedDate,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      code: json['code'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'code': code,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
