import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campeonatos'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChampionshipRegistrationScreen(),
            ),
          ).then((_) {
            context.read<ChampionshipListViewModel>().loadChampionships();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ChampionshipListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ChampionshipListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == ChampionshipListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar campeonatos'),
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
                subtitle: Text('${championship.season} - ${championship.startDate} a ${championship.endDate}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      // Navigate to edit screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChampionshipRegistrationScreen(
                            championshipToEdit: championship,
                          ),
                        ),
                      ).then((_) {
                        context.read<ChampionshipListViewModel>().loadChampionships();
                      });
                    } else if (value == 'delete') {
                      // Confirm delete
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: const Text('Deseja realmente excluir este campeonato?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ChampionshipListViewModel>().deleteChampionship(championship.id);
                                Navigator.pop(context);
                              },
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Editar'),
                    ),
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
}
