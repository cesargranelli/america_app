import 'dart:ffi';

import 'organization.dart';

class League {
  Long id;
  String name;
  String acronym;
  String code;
  Organization organization;
  DateTime foundationDate;
  DateTime createdDate;
  DateTime updatedDate;

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
}
