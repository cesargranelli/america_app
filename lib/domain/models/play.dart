enum PlayType {
  touchdown,
  fieldGoal,
  extraPoint,
  safety,
  fumble,
  interception,
  sack,
  pass,
  run,
  punt,
  kickoff,
  penalty,
  timeout,
  endOfQuarter,
  endOfGame
}

class Play {
  final String id;
  final String gameId;
  final PlayType type;
  final String description;
  final String? teamId; // Team that made the play
  final String? athleteId; // Athlete involved (optional)
  final int quarter;
  final String time; // Game clock time
  final int down;
  final int yardsToGo;
  final int yardLine; // Field position (0-100)

  Play({
    required this.id,
    required this.gameId,
    required this.type,
    required this.description,
    this.teamId,
    this.athleteId,
    required this.quarter,
    required this.time,
    required this.down,
    required this.yardsToGo,
    required this.yardLine,
  });

  factory Play.fromJson(Map<String, dynamic> json) {
    return Play(
      id: json['id'] ?? '',
      gameId: json['gameId'] ?? '',
      type: PlayType.values.firstWhere(
          (e) => e.toString() == 'PlayType.${json['type']}',
          orElse: () => PlayType.run),
      description: json['description'] ?? '',
      teamId: json['teamId'],
      athleteId: json['athleteId'],
      quarter: json['quarter'] ?? 1,
      time: json['time'] ?? '00:00',
      down: json['down'] ?? 1,
      yardsToGo: json['yardsToGo'] ?? 10,
      yardLine: json['yardLine'] ?? 20,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gameId': gameId,
      'type': type.toString().split('.').last,
      'description': description,
      'teamId': teamId,
      'athleteId': athleteId,
      'quarter': quarter,
      'time': time,
      'down': down,
      'yardsToGo': yardsToGo,
      'yardLine': yardLine,
    };
  }
}
