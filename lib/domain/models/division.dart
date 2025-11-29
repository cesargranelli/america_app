class Division {
  final String id;
  final String name;
  final String conferenceId;

  Division({
    required this.id,
    required this.name,
    required this.conferenceId,
  });

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'],
      name: json['name'],
      conferenceId: json['conferenceId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'conferenceId': conferenceId,
    };
  }
}
