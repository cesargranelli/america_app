import 'dart:ffi';

class Organization {
  Long id;
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
}
