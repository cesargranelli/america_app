class Organization {
  int id;
  String name;
  String description;
  String code;
  DateTime createdDate;
  DateTime updatedDate;

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
}
