import 'package:america_app/models/standings.dart';
import 'package:flutter/material.dart';

import '../../models/championship.dart';
import '../../models/team_standings.dart';
import '../../services/stanging_service.dart';

class FlagStandingsScreen extends StatefulWidget {
  const FlagStandingsScreen({super.key});

  @override
  State<FlagStandingsScreen> createState() => _FlagStandingsScreenState();
}

class _FlagStandingsScreenState extends State<FlagStandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedChampionshipIndex;

  final StandingService _standingService = StandingService();

  Future<void> _fetchStandings() async {
    // try {
    final Future<Standings?> standings = _standingService.getStandings(
      'APFA FLAG x8 - Masculino',
    );
    //   standings.then((value) {
    //     if (value != null) {
    //       setState(() {
    //         _competitionStandings.clear();
    //         _competitionStandings.addAll(value.competitionStandings);
    //       });
    //     } else {
    //       print('Nenhum dado de classificação encontrado.');
    //     }
    //   });
    // } catch (e) {
    //   print('Erro ao carregar perfil: ${e.toString()}');
    // } finally {
    //   print('');
    // }
  }

  // final Map<String, Map<String, List<TeamStanding>>> _competitionStandings = {};

  final Map<String, Map<String, List<TeamStanding>>> _competitionStandings = {
    'APFA FLAG x8 - Masculino': {
      'Metrópolis': [
        TeamStanding(
          name: 'Silver Knights',
          logoUrl: 'https://placehold.co/40x40/AA0000/FFFFFF?text=SK',
          wins: 13,
          losses: 4,
          ties: 0,
          sequence: 'W2',
          pointsFor: 450,
          pointsAgainst: 277,
          record: '2-1',
        ),
        TeamStanding(
          name: 'Green Reapers',
          logoUrl: 'https://placehold.co/40x40/002244/69BE28?text=GR',
          wins: 9,
          losses: 8,
          ties: 0,
          sequence: 'W1',
          pointsFor: 407,
          pointsAgainst: 401,
          record: '1-2',
        ),
      ],
      'Caipira': [
        TeamStanding(
          name: 'UNICAMP Eucalyptos',
          logoUrl: 'https://placehold.co/40x40/00338D/FFFFFF?text=UE',
          wins: 11,
          losses: 6,
          ties: 0,
          sequence: 'W2',
          pointsFor: 455,
          pointsAgainst: 310,
          record: '3-0',
        ),
        TeamStanding(
          name: 'São Carlos Bulldogs',
          logoUrl: 'https://placehold.co/40x40/008E97/FFFFFF?text=MIA',
          wins: 9,
          losses: 8,
          ties: 0,
          sequence: 'W2',
          pointsFor: 397,
          pointsAgainst: 397,
          record: '2-1',
        ),
      ],
    },
  };

  final List<TeamStanding> metropolis = [
    TeamStanding(
      name: 'Knights',
      logoUrl: 'https://placehold.co/40x40/AA0000/FFFFFF?text=SF',
      wins: 13,
      losses: 4,
      ties: 0,
      sequence: 'W2',
      pointsFor: 450,
      pointsAgainst: 277,
      record: '2-1',
    ),
    TeamStanding(
      name: 'Reapers',
      logoUrl: 'https://placehold.co/40x40/002244/69BE28?text=SEA',
      wins: 9,
      losses: 8,
      ties: 0,
      sequence: 'W1',
      pointsFor: 407,
      pointsAgainst: 401,
      record: '1-2',
    ),
    TeamStanding(
      name: 'Sharks',
      logoUrl: 'https://placehold.co/40x40/002244/862633?text=LAR',
      wins: 5,
      losses: 12,
      ties: 0,
      sequence: 'W2',
      pointsFor: 307,
      pointsAgainst: 384,
      record: '0-4',
    ),
    TeamStanding(
      name: 'Tigers',
      logoUrl: 'https://placehold.co/40x40/97233F/FFFFFF?text=ARI',
      wins: 4,
      losses: 13,
      ties: 0,
      sequence: 'W2',
      pointsFor: 340,
      pointsAgainst: 449,
      record: '4-0',
    ),
    TeamStanding(
      name: 'Alpacas',
      logoUrl: 'https://placehold.co/40x40/97233F/FFFFFF?text=ARI',
      wins: 4,
      losses: 13,
      ties: 0,
      sequence: 'W2',
      pointsFor: 340,
      pointsAgainst: 449,
      record: '1-2',
    ),
    TeamStanding(
      name: 'Chargers',
      logoUrl: 'https://placehold.co/40x40/97233F/FFFFFF?text=ARI',
      wins: 4,
      losses: 13,
      ties: 0,
      sequence: 'W2',
      pointsFor: 340,
      pointsAgainst: 449,
      record: '2-1',
    ),
  ];

  final List<TeamStanding> caipira = [
    TeamStanding(
      name: 'Eucalyptos',
      logoUrl: 'https://placehold.co/40x40/00338D/FFFFFF?text=ECL',
      wins: 11,
      losses: 6,
      ties: 0,
      sequence: 'W2',
      pointsFor: 455,
      pointsAgainst: 310,
      record: '3-0',
    ),
    TeamStanding(
      name: 'Bulldogs',
      logoUrl: 'https://placehold.co/40x40/008E97/FFFFFF?text=MIA',
      wins: 9,
      losses: 8,
      ties: 0,
      sequence: 'W2',
      pointsFor: 397,
      pointsAgainst: 397,
      record: '2-1',
    ),
    TeamStanding(
      name: 'Titans',
      logoUrl: 'https://placehold.co/40x40/002244/FFFFFF?text=NE',
      wins: 8,
      losses: 9,
      ties: 0,
      sequence: 'W2',
      pointsFor: 364,
      pointsAgainst: 347,
      record: '1-2',
    ),
    TeamStanding(
      name: 'Weavers',
      logoUrl: 'https://placehold.co/40x40/125740/FFFFFF?text=NYJ',
      wins: 7,
      losses: 10,
      ties: 0,
      sequence: 'W2',
      pointsFor: 296,
      pointsAgainst: 316,
      record: '1-2',
    ),
    TeamStanding(
      name: 'Tomahawk',
      logoUrl: 'https://placehold.co/40x40/125740/FFFFFF?text=NYJ',
      wins: 7,
      losses: 10,
      ties: 0,
      sequence: 'W2',
      pointsFor: 296,
      pointsAgainst: 316,
      record: '0-3',
    ),
    TeamStanding(
      name: 'Alligators',
      logoUrl: 'https://placehold.co/40x40/125740/FFFFFF?text=NYJ',
      wins: 7,
      losses: 10,
      ties: 0,
      sequence: 'W2',
      pointsFor: 296,
      pointsAgainst: 316,
      record: '0-2',
    ),
  ];

  late final List<Championship> _championships;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedChampionshipIndex = 0;

    _championships = [
      Championship(
        name: _competitionStandings.entries.first.key,
        competitionStandings: _competitionStandings.entries.first.value,
      ),
    ];

    _fetchStandings();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Championship get _currentChampionship =>
      _championships[_selectedChampionshipIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<int>(
          value: _selectedChampionshipIndex,
          icon: const Icon(Icons.arrow_drop_down),
          underline: Container(),
          onChanged: (int? newValue) {
            setState(() {
              _selectedChampionshipIndex = newValue!;
            });
          },
          items: _championships.asMap().entries.map((entry) {
            int idx = entry.key;
            Championship champ = entry.value;
            return DropdownMenuItem<int>(
              value: idx,
              child: Text(
                champ.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'COMPETIÇÃO')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCompetitionStandings()],
      ),
    );
  }

  Widget _buildCompetitionStandings() {
    final currentConferences = _currentChampionship.competitionStandings;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: currentConferences.entries.expand((entry) {
          final conferenceName = entry.key;
          final teams = entry.value;
          return [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                conferenceName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            _buildStandingsHeader(),
            ...teams.map((team) => _buildTeamRow(team)).toList(),
          ];
        }).toList(),
      ),
    );
  }

  Widget _buildStandingsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 48 + 8),
          const Expanded(
            flex: 3,
            child: Text(
              'TIME',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          _buildHeaderStat('REC', 1),
          _buildHeaderStat('PF', 1),
          _buildHeaderStat('PC', 1),
          _buildHeaderStat('SEQ', 1),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String text, double flex) {
    return Expanded(
      flex: flex.toInt(),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildTeamRow(TeamStanding team) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              team.logoUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 40,
                height: 40,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    team.name[0],
                    style: TextStyle(color: Colors.grey[600], fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              team.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          _buildTeamStat(team.record),
          _buildTeamStat(team.pointsFor.toString()),
          _buildTeamStat(team.pointsAgainst.toString()),
          _buildTeamStat(team.sequence),
        ],
      ),
    );
  }

  Widget _buildTeamStat(String value) {
    return Expanded(
      flex: 1,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
