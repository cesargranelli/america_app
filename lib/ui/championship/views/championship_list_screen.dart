import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/league.dart';
import '../view_models/championship_list_view_model.dart';
import 'championship_registration_screen.dart';
import 'championship_screen.dart';

class ChampionshipListScreen extends StatefulWidget {
  final League? league;

  const ChampionshipListScreen({super.key, this.league});

  @override
  State<ChampionshipListScreen> createState() => _ChampionshipListScreenState();
}

class _ChampionshipListScreenState extends State<ChampionshipListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChampionshipListViewModel>().loadChampionships();
    });
  }

  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChampionshipRegistrationScreen(league: widget.league),
      ),
    ).then((_) {
      if (mounted) {
        context.read<ChampionshipListViewModel>().loadChampionships();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campeonatos')),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegistration,
        child: const Icon(Icons.add),
      ),
      body: Consumer<ChampionshipListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ChampionshipListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == ChampionshipListState.error) {
            return Center(
              child: Text(
                viewModel.errorMessage ?? 'Erro ao carregar campeonatos',
              ),
            );
          } else if (viewModel.championships.isEmpty) {
            return const Center(child: Text('Nenhum campeonato cadastrado.'));
          }

          return ListView.builder(
            itemCount: viewModel.championships.length,
            itemBuilder: (context, index) {
              final championship = viewModel.championships[index];
              return ListTile(
                minTileHeight: 80,
                leading: Hero(
                  tag: 'championship_hero_${championship.id}',
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withValues(alpha: 0.1),
                    ),
                    child: const Icon(
                      Icons.sports_football,
                      color: Colors.orange,
                    ),
                  ),
                ),
                title: Text(championship.name),
                subtitle: Text(championship.season),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChampionshipScreen(championship: championship),
                    ),
                  ).then((_) {
                    if (mounted)
                      context
                          .read<ChampionshipListViewModel>()
                          .loadChampionships();
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
