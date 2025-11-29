class Athlete {
  final String id;
  final String name;
  final String position;
  final String teamId;

  Athlete({
    required this.id,
    required this.name,
    required this.position,
    required this.teamId,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      teamId: json['teamId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'teamId': teamId,
    };
  }
}
