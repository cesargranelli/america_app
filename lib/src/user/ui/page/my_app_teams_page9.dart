import 'package:flutter/material.dart';

// Enum para definir o time do evento
enum EventTeam { teamA, teamB }

class MyAppTeamsPage9 extends StatelessWidget {
  const MyAppTeamsPage9({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Timeline',
      theme: ThemeData(
        useMaterial3: true, // Habilita o Material 3
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Fundo branco como na imagem
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFF4A4A4A),
          ), // Cor padrão do texto
          bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
        ),
      ),
      home: GameTimelineScreen(),
    );
  }
}

class GameTimelineScreen extends StatefulWidget {
  const GameTimelineScreen({super.key});

  @override
  _GameTimelineScreenState createState() => _GameTimelineScreenState();
}

class _GameTimelineScreenState extends State<GameTimelineScreen> {
  // Lista de eventos para a timeline
  final List<TimelineEvent> _events = [
    TimelineEvent(
      time: '17:37:55',
      title: 'Início do 1º tempo',
      description: null,
      isFirstDown: false,
      team: EventTeam.teamA, // Evento do Time A
    ),
    TimelineEvent(
      time: '17:39:00',
      title: '1ª descida / pass',
      description: 'Resultado: reception',
      isFirstDown: false,
      team: EventTeam.teamB, // Evento do Time B
    ),
    TimelineEvent(
      time: '17:40:15',
      title: '2ª descida / run',
      description: 'Resultado: reception',
      isFirstDown: true,
      team: EventTeam.teamA, // Evento do Time A
    ),
    TimelineEvent(
      time: '17:42:00',
      title: '3ª descida / sack',
      description: 'Perda de 5 jardas',
      isFirstDown: false,
      team: EventTeam.teamB, // Evento do Time B
    ),
    TimelineEvent(
      time: '17:43:30',
      title: 'Touchdown!',
      description: 'Passe longo para o WR',
      isFirstDown: false,
      team: EventTeam.teamA, // Evento do Time A
    ),
    TimelineEvent(
      time: '17:45:00',
      title: 'Extra Point',
      description: 'Chute bloqueado',
      isFirstDown: false,
      team: EventTeam.teamB, // Evento do Time B
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(context, 'Timeline', true),
              _buildTabItem(context, 'Estatísticas', false),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Alterado de 'Ataque' para 'Time A'
                Text(
                  'Time A',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
                // Alterado de 'Defesa' para 'Time B'
                Text(
                  'Time B',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              itemCount: _events.length,
              itemBuilder: (context, index) {
                final event = _events[index];
                return TimelineTile(
                  event: event,
                  isFirst: index == 0,
                  isLast: index == _events.length - 1,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Encerrar 1º Tempo');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('ENCERRAR 1º TEMPO'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    print('Continuar 1º Tempo');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('CONTINUAR 1º TEMPO'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Lógica para mudar de aba
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue : Color(0xFF4A4A4A),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class TimelineEvent {
  final String time;
  final String title;
  final String? description;
  final bool isFirstDown;
  final EventTeam team; // Adicionada a propriedade team

  TimelineEvent({
    required this.time,
    required this.title,
    this.description,
    this.isFirstDown = false,
    required this.team, // Agora é obrigatório
  });
}

class TimelineTile extends StatelessWidget {
  final TimelineEvent event;
  final bool isFirst;
  final bool isLast;

  const TimelineTile({
    super.key,
    required this.event,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine a cor do ponto e da borda do card com base no time
    final Color dotColor = event.team == EventTeam.teamA
        ? Colors.blue.shade700
        : Colors.orange.shade700;
    final Color cardBorderColor = event.team == EventTeam.teamA
        ? Colors.blue.shade100
        : Colors.orange.shade100;
    final Color cardBackgroundColor = event.team == EventTeam.teamA
        ? Colors.blue.shade50
        : Colors.orange.shade50;
    final Color cardTextColor = event.team == EventTeam.teamA
        ? Colors.blue.shade900
        : Colors.orange.shade900;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Conteúdo do Time A (à esquerda)
          if (event.team == EventTeam.teamA)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.end, // Alinha o texto à direita
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        event.time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: cardBackgroundColor, // Cor de fundo do card
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: cardBorderColor,
                        ), // Borda do card
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.end, // Alinha o texto à direita
                        children: [
                          Text(
                            event.title,
                            textAlign:
                                TextAlign.right, // Alinha o texto do título
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: cardTextColor,
                            ),
                          ),
                          if (event.description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              event.description!,
                              textAlign: TextAlign
                                  .right, // Alinha o texto da descrição
                              style: TextStyle(
                                fontSize: 14,
                                color: cardTextColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (event.isFirstDown) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'FIRST DOWN',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

          // Coluna central da linha do tempo e do ponto
          SizedBox(
            width: 60, // Largura para a linha central e o ponto
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? Colors.transparent : Colors.grey[300],
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dotColor, // Cor do círculo baseada no time
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),

          // Conteúdo do Time B (à direita)
          if (event.team == EventTeam.teamB)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinha o texto à esquerda
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        event.time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: cardBackgroundColor, // Cor de fundo do card
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: cardBorderColor,
                        ), // Borda do card
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Alinha o texto à esquerda
                        children: [
                          Text(
                            event.title,
                            textAlign:
                                TextAlign.left, // Alinha o texto do título
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: cardTextColor,
                            ),
                          ),
                          if (event.description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              event.description!,
                              textAlign:
                                  TextAlign.left, // Alinha o texto da descrição
                              style: TextStyle(
                                fontSize: 14,
                                color: cardTextColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (event.isFirstDown) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.blue.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'FIRST DOWN',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
