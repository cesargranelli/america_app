import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/championship.dart';
import '../view_models/championship_list_view_model.dart';
import 'championship_registration_screen.dart';

class ChampionshipListScreen extends StatefulWidget {
  const ChampionshipListScreen({super.key});

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

  void _navigateToRegistration({Championship? championship}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChampionshipRegistrationScreen(championshipToEdit: championship),
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
        onPressed: () => _navigateToRegistration(),
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
                title: Text(championship.name),
                subtitle: Text(
                  '${championship.season} - ${championship.startDate} a ${championship.endDate}',
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _navigateToRegistration(championship: championship);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, viewModel, championship.id);
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
    ChampionshipListViewModel viewModel,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir este campeonato?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteChampionship(id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
