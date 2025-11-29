class Championship {
  final String id;
  final String name;
  final String season;
  final String startDate;
  final String endDate;

  Championship({
    required this.id,
    required this.name,
    required this.season,
    required this.startDate,
    required this.endDate,
  });

  factory Championship.fromJson(Map<String, dynamic> json) {
    return Championship(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'season': season,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}
