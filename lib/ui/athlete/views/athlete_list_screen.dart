import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/athlete.dart';
import '../view_models/athlete_list_view_model.dart';
import 'athlete_registration_screen.dart';

class AthleteListScreen extends StatefulWidget {
  const AthleteListScreen({super.key});

  @override
  State<AthleteListScreen> createState() => _AthleteListScreenState();
}

class _AthleteListScreenState extends State<AthleteListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AthleteListViewModel>().loadAthletes();
    });
  }

  void _navigateToRegistration({Athlete? athlete}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AthleteRegistrationScreen(athleteToEdit: athlete),
      ),
    ).then((_) {
      if (mounted) {
        context.read<AthleteListViewModel>().loadAthletes();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atletas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToRegistration(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<AthleteListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == AthleteListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == AthleteListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar atletas'),
            );
          } else if (viewModel.athletes.isEmpty) {
            return const Center(child: Text('Nenhum atleta cadastrado.'));
          }

          return ListView.builder(
            itemCount: viewModel.athletes.length,
            itemBuilder: (context, index) {
              final athlete = viewModel.athletes[index];
              return ListTile(
                title: Text(athlete.name),
                subtitle: Text(
                  'Posição: ${athlete.position} | Time ID: ${athlete.teamId}',
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _navigateToRegistration(athlete: athlete);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, viewModel, athlete.id);
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
    AthleteListViewModel viewModel,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir este atleta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteAthlete(id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
