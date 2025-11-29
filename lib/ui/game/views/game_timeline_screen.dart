import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/game_timeline_view_model.dart';

class GameTimelineScreen extends StatelessWidget {
  final String gameId;

  const GameTimelineScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameTimelineViewModel(
        playRepository: context.read(),
      )..loadPlays(gameId),
      child: _GameTimelineView(gameId: gameId),
    );
  }
}

class _GameTimelineView extends StatelessWidget {
  final String gameId;

  const _GameTimelineView({required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline do Jogo'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameTimelineViewModel>().loadPlays(gameId);
            },
          ),
        ],
      ),
      body: Consumer<GameTimelineViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == GameTimelineState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == GameTimelineState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar timeline'),
            );
          } else if (viewModel.plays.isEmpty) {
            return const Center(child: Text('Nenhuma jogada registrada.'));
          }

          return ListView.builder(
            itemCount: viewModel.plays.length,
            itemBuilder: (context, index) {
              final play = viewModel.plays[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFFAC638),
                    child: Text(
                      '${play.quarter}Q',
                      style: const TextStyle(color: Color(0xFF4A4A4A)),
                    ),
                  ),
                  title: Text(
                    play.type.toString().split('.').last.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(play.description),
                      const SizedBox(height: 4),
                      Text(
                        '${play.time} | ${play.down}ª & ${play.yardsToGo} | Linha: ${play.yardLine}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
