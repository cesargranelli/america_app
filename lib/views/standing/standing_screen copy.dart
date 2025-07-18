import 'package:flutter/material.dart';

class TeamStanding {
  final String name;
  final String logoUrl;
  final String record;
  final int wins;
  final int losses;
  final int ties;
  final double winPercentage;
  final int pointsFor;
  final int pointsAgainst;

  TeamStanding({
    required this.name,
    required this.logoUrl,
    required this.record,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.winPercentage,
    required this.pointsFor,
    required this.pointsAgainst,
  });
}

// NOVO: Modelo de dados para um Campeonato
class Championship {
  final String name;
  final Map<String, List<TeamStanding>> conferenceStandings;
  final List<TeamStanding> leagueStandings;

  Championship({
    required this.name,
    required this.conferenceStandings,
    required this.leagueStandings,
  });
}

class NFLStandingsScreen extends StatefulWidget {
  const NFLStandingsScreen({super.key});

  @override
  State<NFLStandingsScreen> createState() => _NFLStandingsScreenState();
}

class _NFLStandingsScreenState extends State<NFLStandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedChampionshipIndex;

  // Dados de exemplo para as classificações (reorganizados para múltiplos campeonatos)
  // NFL Data

  final List<TeamStanding> metropolis = [
    TeamStanding(
      name: 'Knights',
      logoUrl: 'https://placehold.co/40x40/AA0000/FFFFFF?text=SF',
      wins: 13,
      losses: 4,
      ties: 0,
      winPercentage: 0.765,
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
      winPercentage: 0.529,
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
      winPercentage: 0.294,
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
      winPercentage: 0.235,
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
      winPercentage: 0.235,
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
      winPercentage: 0.235,
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
      winPercentage: 0.647,
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
      winPercentage: 0.529,
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
      winPercentage: 0.471,
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
      winPercentage: 0.412,
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
      winPercentage: 0.412,
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
      winPercentage: 0.412,
      pointsFor: 296,
      pointsAgainst: 316,
      record: '0-2',
    ),
  ];
  final List<TeamStanding> nflLeagueStandings = [
    TeamStanding(
      name: 'Chiefs',
      logoUrl: 'https://placehold.co/40x40/E31837/FFB81C?text=KC',
      wins: 14,
      losses: 3,
      ties: 0,
      winPercentage: 0.824,
      pointsFor: 496,
      pointsAgainst: 369,
      record: 'W5',
    ),
    TeamStanding(
      name: 'Eagles',
      logoUrl: 'https://placehold.co/40x40/004C54/A5ACAF?text=PHI',
      wins: 14,
      losses: 3,
      ties: 0,
      winPercentage: 0.824,
      pointsFor: 477,
      pointsAgainst: 344,
      record: 'W1',
    ),
    TeamStanding(
      name: 'Bills',
      logoUrl: 'https://placehold.co/40x40/00338D/FFFFFF?text=BUF',
      wins: 13,
      losses: 4,
      ties: 0,
      winPercentage: 0.765,
      pointsFor: 455,
      pointsAgainst: 310,
      record: 'W5',
    ),
    TeamStanding(
      name: '49ers',
      logoUrl: 'https://placehold.co/40x40/AA0000/FFFFFF?text=SF',
      wins: 13,
      losses: 4,
      ties: 0,
      winPercentage: 0.765,
      pointsFor: 450,
      pointsAgainst: 277,
      record: 'W10',
    ),
    TeamStanding(
      name: 'Bengals',
      logoUrl: 'https://placehold.co/40x40/FB4F14/000000?text=CIN',
      wins: 12,
      losses: 4,
      ties: 0,
      winPercentage: 0.750,
      pointsFor: 418,
      pointsAgainst: 335,
      record: 'W8',
    ),
    TeamStanding(
      name: 'Cowboys',
      logoUrl: 'https://placehold.co/40x40/041E42/869397?text=DAL',
      wins: 12,
      losses: 5,
      ties: 0,
      winPercentage: 0.706,
      pointsFor: 467,
      pointsAgainst: 342,
      record: 'L1',
    ),
  ];

  // NCAA Data (exemplo)
  final List<TeamStanding> ncaaSec = [
    TeamStanding(
      name: 'Georgia',
      logoUrl: 'https://placehold.co/40x40/BA0C2F/FFFFFF?text=UGA',
      wins: 15,
      losses: 0,
      ties: 0,
      winPercentage: 1.000,
      pointsFor: 607,
      pointsAgainst: 214,
      record: 'W15',
    ),
    TeamStanding(
      name: 'Alabama',
      logoUrl: 'https://placehold.co/40x40/660000/FFFFFF?text=BAMA',
      wins: 11,
      losses: 2,
      ties: 0,
      winPercentage: 0.846,
      pointsFor: 512,
      pointsAgainst: 247,
      record: 'W1',
    ),
  ];
  final List<TeamStanding> ncaaBigTen = [
    TeamStanding(
      name: 'Michigan',
      logoUrl: 'https://placehold.co/40x40/FFCB05/00274C?text=UM',
      wins: 13,
      losses: 1,
      ties: 0,
      winPercentage: 0.929,
      pointsFor: 529,
      pointsAgainst: 244,
      record: 'L1',
    ),
    TeamStanding(
      name: 'Ohio St',
      logoUrl: 'https://placehold.co/40x40/BB0000/FFFFFF?text=OSU',
      wins: 11,
      losses: 2,
      ties: 0,
      winPercentage: 0.846,
      pointsFor: 569,
      pointsAgainst: 259,
      record: 'L1',
    ),
  ];
  final List<TeamStanding> ncaaLeagueStandings = [
    TeamStanding(
      name: 'Georgia',
      logoUrl: 'https://placehold.co/40x40/BA0C2F/FFFFFF?text=UGA',
      wins: 15,
      losses: 0,
      ties: 0,
      winPercentage: 1.000,
      pointsFor: 607,
      pointsAgainst: 214,
      record: 'W15',
    ),
    TeamStanding(
      name: 'Michigan',
      logoUrl: 'https://placehold.co/40x40/FFCB05/00274C?text=UM',
      wins: 13,
      losses: 1,
      ties: 0,
      winPercentage: 0.929,
      pointsFor: 529,
      pointsAgainst: 244,
      record: 'L1',
    ),
    TeamStanding(
      name: 'TCU',
      logoUrl: 'https://placehold.co/40x40/4D1979/FFFFFF?text=TCU',
      wins: 13,
      losses: 2,
      ties: 0,
      winPercentage: 0.867,
      pointsFor: 588,
      pointsAgainst: 395,
      record: 'L1',
    ),
  ];

  // Lista de todos os campeonatos disponíveis
  late final List<Championship> _championships;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedChampionshipIndex = 0; // Começa com o primeiro campeonato (NFL)

    _championships = [
      Championship(
        name: 'APFA FLAG x8 - Masculino',
        conferenceStandings: {'Metrópolis': metropolis, 'Caipira': caipira},
        leagueStandings: nflLeagueStandings,
      ),
      Championship(
        name: 'APFA FLAG x5 - Masculino',
        conferenceStandings: {'SEC': ncaaSec, 'Big Ten': ncaaBigTen},
        leagueStandings: ncaaLeagueStandings,
      ),
      Championship(
        name: 'APFA FLAG x5 - Feminino',
        conferenceStandings: {'SEC': ncaaSec, 'Big Ten': ncaaBigTen},
        leagueStandings: ncaaLeagueStandings,
      ),
      Championship(
        name: 'CBFA FLAG x5 - Masculino',
        conferenceStandings: {'SEC': ncaaSec, 'Big Ten': ncaaBigTen},
        leagueStandings: ncaaLeagueStandings,
      ),
      Championship(
        name: 'CBFA FLAG x5 - Feminino',
        conferenceStandings: {'SEC': ncaaSec, 'Big Ten': ncaaBigTen},
        leagueStandings: ncaaLeagueStandings,
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Obtém o campeonato atualmente selecionado
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
          tabs: const [
            Tab(text: 'CONFERÊNCIA'),
            Tab(text: 'LIGA'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildConferenceStandings(), // Conteúdo para a aba Conferência
          _buildLeagueStandings(), // Conteúdo para a aba Liga
        ],
      ),
    );
  }

  Widget _buildConferenceStandings() {
    final currentConferences = _currentChampionship.conferenceStandings;
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

  Widget _buildLeagueStandings() {
    final currentLeagueTeams = _currentChampionship.leagueStandings;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStandingsHeader(),
          ...currentLeagueTeams.map((team) => _buildTeamRow(team)).toList(),
        ],
      ),
    );
  }

  // Cabeçalho da tabela de classificações
  Widget _buildStandingsHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100], // Fundo cinza claro para o cabeçalho
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const SizedBox(width: 48 + 8), // Espaço para logo + padding
          const Expanded(
            flex: 3,
            child: Text(
              'TIME',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          _buildHeaderStat('V', 1),
          _buildHeaderStat('D', 1),
          _buildHeaderStat('E', 1),
          _buildHeaderStat('PCT', 1.2),
          _buildHeaderStat('PF', 1),
          _buildHeaderStat('PA', 1),
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

  // Linha individual de cada time na classificação
  Widget _buildTeamRow(TeamStanding team) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ), // Divisor entre linhas
      ),
      child: Row(
        children: [
          // Logo do time
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
          // Nome do time
          Expanded(
            flex: 3,
            child: Text(
              team.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          // Estatísticas
          _buildTeamStat(team.wins.toString()),
          _buildTeamStat(team.losses.toString()),
          _buildTeamStat(team.ties.toString()),
          _buildTeamStat(
            team.winPercentage.toStringAsFixed(3).substring(1),
          ), // .XXX
          _buildTeamStat(team.pointsFor.toString()),
          _buildTeamStat(team.pointsAgainst.toString()),
          _buildTeamStat(team.record),
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
