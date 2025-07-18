class TeamStanding {
  final String name;
  final String logoUrl;
  final String record;
  final int pointsFor;
  final int pointsAgainst;
  final String sequence;
  final int wins;
  final int losses;
  final int ties;

  TeamStanding({
    required this.name,
    required this.logoUrl,
    required this.record,
    required this.pointsFor,
    required this.pointsAgainst,
    required this.sequence,
    required this.wins,
    required this.losses,
    required this.ties,
  });
}
