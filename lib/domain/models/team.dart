class Team {
  final String id;
  final String name;
  final String city;
  final String divisionId;

  Team({
    required this.id,
    required this.name,
    required this.city,
    required this.divisionId,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      divisionId: json['divisionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'divisionId': divisionId,
    };
  }
}
