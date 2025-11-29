import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/division_list_view_model.dart';
import 'division_registration_screen.dart';

class DivisionListScreen extends StatefulWidget {
  const DivisionListScreen({super.key});

  @override
  State<DivisionListScreen> createState() => _DivisionListScreenState();
}

class _DivisionListScreenState extends State<DivisionListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DivisionListViewModel>().loadDivisions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divisões'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DivisionRegistrationScreen(),
            ),
          ).then((_) {
            context.read<DivisionListViewModel>().loadDivisions();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<DivisionListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == DivisionListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == DivisionListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar divisões'),
            );
          } else if (viewModel.divisions.isEmpty) {
            return const Center(child: Text('Nenhuma divisão cadastrada.'));
          }

          return ListView.builder(
            itemCount: viewModel.divisions.length,
            itemBuilder: (context, index) {
              final division = viewModel.divisions[index];
              return ListTile(
                title: Text(division.name),
                subtitle: Text('ID Conferência: ${division.conferenceId}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DivisionRegistrationScreen(
                            divisionToEdit: division,
                          ),
                        ),
                      ).then((_) {
                        context.read<DivisionListViewModel>().loadDivisions();
                      });
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: const Text('Deseja realmente excluir esta divisão?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<DivisionListViewModel>().deleteDivision(division.id);
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
