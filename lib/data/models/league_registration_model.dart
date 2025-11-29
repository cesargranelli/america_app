class LeagueRegistrationModel {
  final String name;
  final String acronym;
  final String foundationDate;
  final String organizationCode;

  LeagueRegistrationModel({
    required this.name,
    required this.acronym,
    required this.foundationDate,
    required this.organizationCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'acronym': acronym,
      'foundationDate': foundationDate,
      'organizationCode': organizationCode,
    };
  }
}
