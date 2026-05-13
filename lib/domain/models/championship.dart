class Championship {
  final String id;
  final String name;
  final String season;
  final String startDate;
  final String endDate;
  final String leagueId;

  Championship({
    required this.id,
    required this.name,
    required this.season,
    required this.startDate,
    required this.endDate,
    required this.leagueId,
  });

  factory Championship.fromFirestore(String docId, Map<String, dynamic>? data) {
    return Championship(
      id: docId,
      name: data!['name'] as String,
      season: data['season'] as String,
      startDate: data['startDate'] as String,
      endDate: data['endDate'] as String,
      leagueId: data['leagueId'] as String,
    );
  }

  factory Championship.fromJson(Map<String, dynamic> json) {
    return Championship(
      id: json['id'],
      name: json['name'],
      season: json['season'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      leagueId: json['leagueId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'season': season,
      'startDate': startDate,
      'endDate': endDate,
      'leagueId': leagueId,
    };
  }
}
