class League {
  final String id;
  final String name;
  final String description;
  final String acronym;
  final String logo;
  final String city;
  final String state;
  final String country;

  League(
    this.city,
    this.state, {
    required this.id,
    required this.name,
    required this.description,
    required this.acronym,
    required this.logo,
    required this.country,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      json['city'] as String,
      json['state'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      acronym: json['acronym'] as String,
      logo: json['logo'] as String,
      country: json['country'] as String,
    );
  }
}
