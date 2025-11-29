import 'organization.dart';

class League {
  final int id;
  final String name;
  final String acronym;
  final String code;
  final Organization organization;
  final DateTime foundationDate;
  final DateTime createdDate;
  final DateTime updatedDate;

  League({
    required this.id,
    required this.name,
    required this.acronym,
    required this.code,
    required this.organization,
    required this.foundationDate,
    required this.createdDate,
    required this.updatedDate,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      acronym: json['acronym'],
      code: json['code'],

      organization: Organization.fromJson(json['organization']),

      foundationDate: DateTime.parse(json['foundationDate']),
      createdDate: DateTime.parse(json['createdDate']),
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }
}
