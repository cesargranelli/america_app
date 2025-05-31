import 'package:flutter/material.dart';

class MyLineTeamsPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linha do Tempo Futebol Americano',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange, // Mantendo a cor primária para AppBar
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily:
            'Montserrat', // Uma fonte moderna, você pode importar via pubspec.yaml
      ),
      home: FootballTimelineScreenModern(),
    );
  }
}

class FootballTimelineScreenModern extends StatefulWidget {
  @override
  _FootballTimelineScreenModernState createState() =>
      _FootballTimelineScreenModernState();
}

class _FootballTimelineScreenModernState
    extends State<FootballTimelineScreenModern> {
  // Definindo os dois times e suas cores
  final String team1Abbr = 'KC';
  final String team1Name = 'Chiefs';
  final Color team1Color = Colors.red.shade700;

  final String team2Abbr = 'BUF';
  final String team2Name = 'Bills';
  final Color team2Color = Colors.blue.shade700;

  // Mapa de cores para facilitar o acesso
  late final Map<String, Color> teamColors = {
    team1Abbr: team1Color,
    team2Abbr: team2Color,
  };

  // Lista de eventos da linha do tempo
  final List<Map<String, dynamic>> timelineEvents = [
    {
      'type': 'advance',
      'quarter': '1º Q',
      'time': '12:30',
      'description': 'Passe de Patrick Mahomes para Travis Kelce (15 jardas).',
      'yardage': 15,
      'players': {'QB': 'P. Mahomes', 'TE': 'T. Kelce'},
      'score': '0-0',
      'team': 'KC',
    },
    {
      'type': 'advance',
      'quarter': '1º Q',
      'time': '10:15',
      'description': 'Corrida de Isiah Pacheco (8 jardas).',
      'yardage': 8,
      'players': {'RB': 'I. Pacheco'},
      'score': '0-0',
      'team': 'KC',
    },
    {
      'type': 'score',
      'quarter': '1º Q',
      'time': '08:00',
      'description': 'TOUCHDOWN! Passe de P. Mahomes para T. Hill (25 jardas).',
      'yardage': 25,
      'players': {'QB': 'P. Mahomes', 'WR': 'T. Hill'},
      'score': '7-0',
      'scorer': 'KC',
      'score_type': 'TD',
      'team': 'KC',
    },
    {
      'type': 'advance',
      'quarter': '2º Q',
      'time': '14:00',
      'description': 'Passe incompleto de Josh Allen para Stefon Diggs.',
      'yardage': 0,
      'players': {'QB': 'J. Allen', 'WR': 'S. Diggs'},
      'score': '7-0',
      'team': 'BUF',
    },
    {
      'type': 'advance',
      'quarter': '2º Q',
      'time': '12:00',
      'description':
          'Passe completo de J. Allen para Gabriel Davis (10 jardas).',
      'yardage': 10,
      'players': {'QB': 'J. Allen', 'WR': 'G. Davis'},
      'score': '7-0',
      'team': 'BUF',
    },
    {
      'type': 'score',
      'quarter': '2º Q',
      'time': '05:30',
      'description': 'FIELD GOAL! Tyler Bass acerta um chute de 40 jardas.',
      'yardage': 40,
      'players': {'K': 'T. Bass'},
      'score': '7-3',
      'scorer': 'BUF',
      'score_type': 'FG',
      'team': 'BUF',
    },
    {
      'type': 'advance',
      'quarter': '3º Q',
      'time': '07:45',
      'description': 'Sack em Patrick Mahomes (-8 jardas).',
      'yardage': -8,
      'players': {'QB': 'P. Mahomes'},
      'score': '7-3',
      'team': 'KC',
    },
    {
      'type': 'score',
      'quarter': '4º Q',
      'time': '02:00',
      'description': 'TOUCHDOWN! Josh Allen corre para 1 jarda.',
      'yardage': 1,
      'players': {'QB': 'J. Allen'},
      'score': '7-10',
      'scorer': 'BUF',
      'score_type': 'TD',
      'team': 'BUF',
    },
    // Adicione mais eventos aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${team1Name} vs ${team2Name}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Fundo branco para um look mais clean
        elevation: 0, // Sem sombra na AppBar
        foregroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.grey.shade50, // Fundo geral da tela, um cinza bem claro
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          itemCount: timelineEvents.length,
          itemBuilder: (context, index) {
            final event = timelineEvents[index];
            final isScoreEvent = event['type'] == 'score';
            final eventTeam = event['team'] as String;

            // Cores baseadas no time
            final teamColor = teamColors[eventTeam]!;

            // Cor do cartão: um cinza claro para todos, para manter a consistência do design moderno
            final cardBackgroundColor = Colors.white;
            // Cor do ícone: a cor principal do time
            final iconColor = teamColor;

            return IntrinsicHeight(
              // Para que a altura do Row se ajuste ao conteúdo
              child: Row(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // Estende a linha para preencher a altura
                children: [
                  // Coluna para a linha do tempo e o ícone
                  Column(
                    children: [
                      Container(
                        width: 32, // Um pouco maior
                        height: 32,
                        decoration: BoxDecoration(
                          color: iconColor, // Cor do ícone é a cor do time
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: iconColor.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          isScoreEvent
                              ? Icons.emoji_events
                              : Icons
                                    .sports_football, // Ícone de troféu para score
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      if (index < timelineEvents.length - 1)
                        Expanded(
                          // Linha expandida para preencher o espaço
                          child: Container(
                            width: 2,
                            color: Colors
                                .grey
                                .shade300, // Linha um pouco mais clara
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ), // Espaçamento entre a linha e o cartão
                  // Conteúdo do Evento (Card)
                  Expanded(
                    child: Card(
                      elevation:
                          6, // Mais elevação para um efeito de profundidade
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // Mais arredondado
                      ),
                      color:
                          cardBackgroundColor, // Fundo branco para todos os cartões
                      margin: const EdgeInsets.only(
                        bottom: 8.0,
                      ), // Espaçamento inferior para o Card
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${event['quarter']} - ${event['time']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // Indicador do time com a cor do time na borda
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: teamColor,
                                      width: 1.5,
                                    ), // Borda com a cor do time
                                  ),
                                  child: Text(
                                    eventTeam,
                                    style: TextStyle(
                                      color:
                                          teamColor, // Texto com a cor do time
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              event['description'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight.bold, // Descrição mais forte
                                color: Colors.black87,
                              ),
                            ),
                            if (event['yardage'] != null &&
                                event['yardage'] != 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  '${event['yardage']} jardas',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            if (isScoreEvent && event['scorer'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  '(${event['scorer']} - ${event['score_type']})',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: teamColor.darken(
                                      0.1,
                                    ), // Mantém a cor do time escurecida
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Placar: ${event['score']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Extensão para escurecer uma cor (útil para o texto do placar)
extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
