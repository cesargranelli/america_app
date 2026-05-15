import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/league.dart';
import '../../championship/views/championship_registration_screen.dart';
import '../../championship/views/championship_screen.dart';
import '../view_models/league_view_model.dart';

class LeagueScreen extends StatefulWidget {
  final League league;

  const LeagueScreen({super.key, required this.league});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LeagueViewModel>().loadChampionships(widget.league);
    });
  }

  void _navigateToRegistration() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChampionshipRegistrationScreen(league: widget.league),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.league.acronym), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRegistration,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'league_${widget.league.id}',
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple.withValues(alpha: 0.1),
                ),
                child: const Center(
                  child: Icon(
                    Icons.emoji_events,
                    color: Colors.deepPurple,
                    size: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.league.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(widget.league.foundationDate),
            const SizedBox(height: 24),
            Text('Campeonatos', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Consumer<LeagueViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == LeagueState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (viewModel.state == LeagueState.error) {
                  return Text(viewModel.errorMessage ?? 'Erro ao carregar');
                } else if (viewModel.championships.isEmpty) {
                  return Text('Nenhum campeonato cadastrado nessa liga');
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.championships.length,
                  itemBuilder: (context, index) {
                    final championship = viewModel.championships[index];
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.orange.withValues(alpha: 0.1),
                        ),
                        child: const Icon(
                          Icons.sports_football,
                          color: Colors.orange,
                        ),
                      ),
                      title: Text(championship.name),
                      subtitle: Text(championship.season),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChampionshipScreen(championship: championship),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
