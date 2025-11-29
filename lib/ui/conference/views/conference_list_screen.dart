import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/conference_list_view_model.dart';
import 'conference_registration_screen.dart';

class ConferenceListScreen extends StatefulWidget {
  const ConferenceListScreen({super.key});

  @override
  State<ConferenceListScreen> createState() => _ConferenceListScreenState();
}

class _ConferenceListScreenState extends State<ConferenceListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ConferenceListViewModel>().loadConferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conferências'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConferenceRegistrationScreen(),
            ),
          ).then((_) {
            context.read<ConferenceListViewModel>().loadConferences();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ConferenceListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ConferenceListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == ConferenceListState.error) {
            return Center(
              child: Text(viewModel.errorMessage ?? 'Erro ao carregar conferências'),
            );
          } else if (viewModel.conferences.isEmpty) {
            return const Center(child: Text('Nenhuma conferência cadastrada.'));
          }

          return ListView.builder(
            itemCount: viewModel.conferences.length,
            itemBuilder: (context, index) {
              final conference = viewModel.conferences[index];
              return ListTile(
                title: Text(conference.name),
                subtitle: Text('ID Campeonato: ${conference.championshipId}'),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConferenceRegistrationScreen(
                            conferenceToEdit: conference,
                          ),
                        ),
                      ).then((_) {
                        context.read<ConferenceListViewModel>().loadConferences();
                      });
                    } else if (value == 'delete') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: const Text('Deseja realmente excluir esta conferência?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ConferenceListViewModel>().deleteConference(conference.id);
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
