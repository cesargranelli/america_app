import 'package:flutter/material.dart';

class MyLineTeamsPage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FootballTimelineScreenModern();
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
  final Color team1Color = Color(0xFFC00021); // Vermelho Chiefs

  final String team2Abbr = 'BUF';
  final String team2Name = 'Bills';
  final Color team2Color = Color(0XFF00338D); // Azul Bills

  // Mapa de cores para facilitar o acesso
  late final Map<String, Color> teamColors = {
    team1Abbr: team1Color,
    team2Abbr: team2Color,
  };

  // Mapa de ícones para cada tipo de jogada
  final Map<String, IconData> playIcons = {
    'run': Icons.directions_run, // Corrida
    'pass_complete': Icons.check_circle_outline, // Passe completo
    'pass_incomplete': Icons.highlight_off, // Passe incompleto
    'drop': Icons.back_hand, // Drop
    'sack': Icons.security, // Sack
    'interception': Icons.remove_red_eye, // Interceptação
    'fumble': Icons.sports_handball, // Fumble
    'td': Icons.emoji_events, // Touchdown
    'field_goal': Icons.sports_soccer, // Field Goal
    'extra_point': Icons.add_circle_outline, // Extra Point
    'safety': Icons.shield_outlined, // Safety
    'kickoff': Icons.arrow_circle_right, // Kickoff
    'punt': Icons.arrow_circle_up, // Punt
  };

  // Lista de eventos da linha do tempo (tipos de jogada mais detalhados)
  // Ordem INVERSA para que o evento mais recente apareça primeiro
  final List<Map<String, dynamic>> timelineEvents = [
    {
      'type': 'score',
      'play_type': 'interception',
      'quarter': '4º Q',
      'time': '02:00',
      'description': 'INTERCEPTAÇÃO! Trevon Diggs retorna para TOUCHDOWN!',
      'yardage': 50,
      'players': {'CB': 'T. Diggs'},
      'score': '7-10',
      'scorer': 'BUF',
      'score_type': 'PICK SIX',
      'team': 'BUF',
    },
    {
      'type': 'advance',
      'play_type': 'sack',
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
      'play_type': 'field_goal',
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
      'play_type': 'pass_complete',
      'quarter': '2º Q',
      'time': '12:00',
      'description':
          'Passe completo de J. Allen para Gabriel Davis para 10 jardas.',
      'yardage': 10,
      'players': {'QB': 'J. Allen', 'WR': 'G. Davis'},
      'score': '7-0',
      'team': 'BUF',
    },
    {
      'type': 'advance',
      'play_type': 'pass_incomplete',
      'quarter': '2º Q',
      'time': '14:00',
      'description': 'Passe incompleto de Josh Allen para Stefon Diggs.',
      'yardage': 0,
      'players': {'QB': 'J. Allen', 'WR': 'S. Diggs'},
      'score': '7-0',
      'team': 'BUF',
    },
    {
      'type': 'score',
      'play_type': 'td',
      'quarter': '1º Q',
      'time': '08:00',
      'description':
          'TOUCHDOWN! Passe de P. Mahomes para T. Hill para 25 jardas.',
      'yardage': 25,
      'players': {'QB': 'P. Mahomes', 'WR': 'T. Hill'},
      'score': '7-0',
      'scorer': 'KC',
      'score_type': 'TD',
      'team': 'KC',
    },
    {
      'type': 'advance',
      'play_type': 'run',
      'quarter': '1º Q',
      'time': '10:15',
      'description': 'Corrida de Isiah Pacheco para 8 jardas.',
      'yardage': 8,
      'players': {'RB': 'I. Pacheco'},
      'score': '0-0',
      'team': 'KC',
    },
    {
      'type': 'advance',
      'play_type': 'pass_complete',
      'quarter': '1º Q',
      'time': '12:30',
      'description':
          'Passe de Patrick Mahomes para Travis Kelce para 15 jardas.',
      'yardage': 15,
      'players': {'QB': 'P. Mahomes', 'TE': 'T. Kelce'},
      'score': '0-0',
      'team': 'KC',
    },
  ].reversed.toList(); // Inverte a lista para decrescente

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${team1Name} vs ${team2Name}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.grey.shade50, // Fundo geral da tela, um cinza bem claro
        child: Column(
          // Usar Column para adicionar o indicador de ordem
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Alinha a indicação à direita
                children: [
                  Text(
                    'Mais Recente Primeiro',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons
                        .south, // Seta para baixo indicando "do topo para o fim" (mais recente para mais antigo)
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ), // Ajuste o padding vertical aqui
                itemCount: timelineEvents.length,
                itemBuilder: (context, index) {
                  final event = timelineEvents[index];
                  final eventTeam = event['team'] as String;
                  final playType = event['play_type'] as String;

                  // Cor base do time
                  final teamColor = teamColors[eventTeam]!;

                  // Gradient para o cartão: cores muito suaves e próximas
                  final LinearGradient cardGradient = LinearGradient(
                    colors: [
                      teamColor
                          .lighten(0.4)
                          .withOpacity(0.4), // Tom muito claro e translúcido
                      teamColor
                          .lighten(0.3)
                          .withOpacity(
                            0.4,
                          ), // Ligeiramente mais escuro, mas ainda suave
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  );

                  // Cores do texto: sempre escuras para contraste com fundos claros
                  final Color textColor = Colors.black87;
                  final Color secondaryTextColor = Colors.grey.shade700;

                  // Cor do ícone no canto do cartão
                  final Color iconContainerColor = Colors.white.withOpacity(
                    0.5,
                  ); // Fundo branco translúcido para o ícone
                  final Color iconColor = teamColor.darken(
                    0.2,
                  ); // Ícone com um tom mais escuro da cor do time

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      // Usando Container em vez de Card para o gradient
                      decoration: BoxDecoration(
                        gradient: cardGradient,
                        borderRadius: BorderRadius.circular(16),
                        // Removendo boxShadow para eliminar sombras e elevação
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Ícone da jogada aqui, no canto superior esquerdo do cartão
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: iconContainerColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    playIcons[playType] ?? Icons.help_outline,
                                    color: iconColor, // Cor do ícone
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    '${event['quarter']} - ${event['time']}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: secondaryTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                // Indicador do time com a cor do time na borda (agora mais integrado)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: iconContainerColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: teamColor.withOpacity(0.4),
                                      width: 1.5,
                                    ), // Borda com a cor do time, mas mais suave
                                  ),
                                  child: Text(
                                    eventTeam,
                                    style: TextStyle(
                                      color: teamColor.darken(
                                        0.1,
                                      ), // Cor do texto da abreviação um pouco mais escura que a base
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            Text(
                              event['description'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: textColor, // Cor do texto principal
                              ),
                            ),
                            if (event['yardage'] != null &&
                                event['yardage'] != 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${event['yardage']} jardas',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: secondaryTextColor, // Cor secundária
                                  ),
                                ),
                              ),
                            if (event['type'] == 'score' &&
                                event['scorer'] != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '(${event['scorer']} - ${event['score_type']})',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryTextColor, // Cor secundária
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Placar: ${event['score']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: textColor, // Cor do placar
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extensão para clarear e escurecer uma cor, e determinar luminância
extension ColorExtension on Color {
  // Clareia a cor
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  // Escurece a cor
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  // Calcula a luminância para decidir a cor do texto
  double computeLuminance() {
    // Usando a fórmula da WCAG para luminância perceptiva
    return (0.299 * red + 0.587 * green + 0.114 * blue) / 255;
  }
}
