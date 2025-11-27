class Standing {
  final String teamId;
  final String teamName;
  final int wins;
  final int losses;
  final int points;

  Standing({
    required this.teamId,
    required this.teamName,
    required this.wins,
    required this.losses,
    required this.points,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      teamId: json['teamId'] ?? '',
      teamName: json['teamName'] ?? 'Unknown',
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      points: json['points'] ?? 0,
    );
  }
}
