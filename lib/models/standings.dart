import 'team_standings.dart';

class Standings {
  final Map<String, Map<String, List<TeamStanding>>> competitionStandings;

  Standings({required this.competitionStandings});

  factory Standings.fromJson(Map<String, dynamic> json) {
    return Standings(
      competitionStandings: Map<String, Map<String, List<TeamStanding>>>.from(
        json['competitionStandings'] as Map,
      ),
    );
  }
}
