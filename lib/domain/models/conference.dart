class Conference {
  final String id;
  final String name;
  final String championshipId;

  Conference({
    required this.id,
    required this.name,
    required this.championshipId,
  });

  factory Conference.fromJson(Map<String, dynamic> json) {
    return Conference(
      id: json['id'],
      name: json['name'],
      championshipId: json['championshipId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'championshipId': championshipId,
    };
  }
}
