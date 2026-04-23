import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/team.dart';
import '../view_models/team_list_view_model.dart';
import 'team_registration_screen.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeamListViewModel>().loadTeams();
    });
  }

  void _navigateToRegistration({Team? team}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamRegistrationScreen(teamToEdit: team),
      ),
    ).then((_) {
      if (mounted) {
        context.read<TeamListViewModel>().loadTeams();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Times')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToRegistration(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<TeamListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == TeamListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == TeamListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar times'),
            );
          } else if (viewModel.teams.isEmpty) {
            return const Center(child: Text('Nenhum time cadastrado.'));
          }

          return ListView.builder(
            itemCount: viewModel.teams.length,
            itemBuilder: (context, index) {
              final team = viewModel.teams[index];
              return ListTile(
                title: Text(team.name),
                subtitle: Text('ID Divisão: ${team.divisionId}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _navigateToRegistration(team: team);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, viewModel, team.id);
                    }
                  },
                  itemBuilder: (context) => [
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
    TeamListViewModel viewModel,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir este time?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteTeam(id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
