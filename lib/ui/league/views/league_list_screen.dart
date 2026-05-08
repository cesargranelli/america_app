import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/league_list_view_model.dart';
import 'league_registration_screen.dart';
import 'league_screen.dart';

class LeagueListScreen extends StatefulWidget {
  const LeagueListScreen({super.key});

  @override
  State<LeagueListScreen> createState() => _LeagueListScreenState();
}

class _LeagueListScreenState extends State<LeagueListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeagueListViewModel>().loadLeagues();
    });
  }

  void _navigateToRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LeagueRegistrationScreen()),
    ).then((_) {
      if (mounted) context.read<LeagueListViewModel>().loadLeagues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ligas')),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegistration,
        child: const Icon(Icons.add),
      ),
      body: Consumer<LeagueListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == LeagueListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == LeagueListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar ligas'),
            );
          } else if (viewModel.leagues.isEmpty) {
            return const Center(child: Text('Nenhuma liga cadastrada.'));
          }

          return ListView.builder(
            itemCount: viewModel.leagues.length,
            itemBuilder: (context, index) {
              final league = viewModel.leagues[index];
              return ListTile(
                minTileHeight: 80,
                leading: Hero(
                  tag: 'league_hero_${league.id}',
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                    ),
                    child: const Icon(Icons.emoji_events, color: Colors.deepPurple),
                  ),
                ),
                title: Text(league.name),
                subtitle: Text(league.acronym),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeagueScreen(league: league)),
                  ).then((_) {
                    if (mounted) context.read<LeagueListViewModel>().loadLeagues();
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
