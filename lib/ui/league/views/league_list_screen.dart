import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/league.dart';
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

  void _navigateToRegistration({League? league}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeagueRegistrationScreen(leagueToEdit: league),
      ),
    ).then((_) {
      if (mounted) {
        context.read<LeagueListViewModel>().loadLeagues();
      }
    });
  }

  void _navigateToLeague({required League league}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeagueScreen(league: league)),
    ).then((_) {
      if (mounted) {
        context.read<LeagueListViewModel>().loadLeagues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ligas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToRegistration(),
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
                title: Text(league.acronym),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'league') {
                      _navigateToLeague(league: league);
                    } else if (value == 'edit') {
                      _navigateToRegistration(league: league);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, viewModel, league.id!);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'league', child: Text('Liga')),
                    const PopupMenuItem(value: 'edit', child: Text('Editar')),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Excluir'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    LeagueListViewModel viewModel,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta liga?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteLeague(id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
