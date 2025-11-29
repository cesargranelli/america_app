import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atletas'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AthleteRegistrationScreen(),
            ),
          ).then((_) {
            context.read<AthleteListViewModel>().loadAthletes();
          });
        },
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
                subtitle: Text('Posição: ${athlete.position} | Time ID: ${athlete.teamId}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AthleteRegistrationScreen(
                            athleteToEdit: athlete,
                          ),
                        ),
                      ).then((_) {
                        context.read<AthleteListViewModel>().loadAthletes();
                      });
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: const Text('Deseja realmente excluir este atleta?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<AthleteListViewModel>().deleteAthlete(athlete.id);
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
