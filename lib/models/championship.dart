import 'package:america_app/models/team_standings.dart';

class Championship {
  final String name;
  final Map<String, List<TeamStanding>> competitionStandings;

  Championship({required this.name, required this.competitionStandings});
}
