import 'package:flutter/material.dart';

class MyLineTeamsPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linha do Tempo Futebol Americano',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FootballTimelineScreen(),
    );
  }
}

class FootballTimelineScreen extends StatefulWidget {
  const FootballTimelineScreen({super.key});

  @override
  _FootballTimelineScreenState createState() => _FootballTimelineScreenState();
}

class _FootballTimelineScreenState extends State<FootballTimelineScreen> {
  // Lista de eventos da linha do tempo
  final List<Map<String, dynamic>> timelineEvents = [
    {
      'type': 'advance',
      'quarter': '1º Quarto',
      'time': '12:30',
      'description':
          'Passe completo de Patrick Mahomes (QB) para Travis Kelce (TE) para 15 jardas.',
      'yardage': 15,
      'players': {'QB': 'Patrick Mahomes', 'TE': 'Travis Kelce'},
      'score': '0-0',
    },
    {
      'type': 'advance',
      'quarter': '1º Quarto',
      'time': '10:15',
      'description': 'Corrida de Isiah Pacheco (RB) para 8 jardas.',
      'yardage': 8,
      'players': {'RB': 'Isiah Pacheco'},
      'score': '0-0',
    },
    {
      'type': 'score',
      'quarter': '1º Quarto',
      'time': '08:00',
      'description':
          'TOUCHDOWN! Passe de Patrick Mahomes (QB) para Tyreek Hill (WR) para 25 jardas.',
      'yardage': 25,
      'players': {'QB': 'Patrick Mahomes', 'WR': 'Tyreek Hill'},
      'score': '7-0',
      'scorer': 'KC',
      'score_type': 'TD',
    },
    {
      'type': 'advance',
      'quarter': '2º Quarto',
      'time': '14:00',
      'description':
          'Passe incompleto de Josh Allen (QB) para Stefon Diggs (WR).',
      'yardage': 0,
      'players': {'QB': 'Josh Allen', 'WR': 'Stefon Diggs'},
      'score': '7-0',
    },
    {
      'type': 'score',
      'quarter': '2º Quarto',
      'time': '05:30',
      'description':
          'FIELD GOAL! Harrison Butker (K) acerta um chute de 40 jardas.',
      'yardage': 40,
      'players': {'K': 'Harrison Butker'},
      'score': '7-3',
      'scorer': 'BUF',
      'score_type': 'FG',
    },
    {
      'type': 'advance',
      'quarter': '3º Quarto',
      'time': '07:45',
      'description':
          'Passe de Matthew Stafford (QB) para Cooper Kupp (WR) para 12 jardas.',
      'yardage': 12,
      'players': {'QB': 'Matthew Stafford', 'WR': 'Cooper Kupp'},
      'score': '7-3',
    },
    {
      'type': 'score',
      'quarter': '4º Quarto',
      'time': '02:00',
      'description':
          'INTERCEPTAÇÃO! Trevon Diggs (CB) intercepta o passe e retorna para TOUCHDOWN!',
      'yardage': 50,
      'players': {'CB': 'Trevon Diggs'},
      'score': '7-10',
      'scorer': 'DAL',
      'score_type': 'PICK SIX',
    },
    // Adicione mais eventos aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Linha do Tempo do Jogo'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: timelineEvents.length,
        itemBuilder: (context, index) {
          final event = timelineEvents[index];
          final isScoreEvent = event['type'] == 'score';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícone da Linha do Tempo e Linha Vertical
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isScoreEvent
                            ? Colors.redAccent
                            : Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isScoreEvent
                            ? Icons.sports_football
                            : Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    if (index < timelineEvents.length - 1)
                      Container(
                        width: 2,
                        height:
                            80, // Ajuste a altura da linha conforme necessário
                        color: Colors.grey[400],
                      ),
                  ],
                ),
                const SizedBox(width: 16.0),
                // Conteúdo do Evento
                Expanded(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${event['quarter']} - ${event['time']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                'Placar: ${event['score']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            event['description'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          if (event['yardage'] > 0 &&
                              event['type'] == 'advance')
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '${event['yardage']} jardas',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          if (isScoreEvent && event['scorer'] != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'Marcador: ${event['scorer']} (${event['score_type']})',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
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
    );
  }
}
