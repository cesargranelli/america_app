import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/conference.dart';
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

  void _navigateToRegistration({Conference? conference}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ConferenceRegistrationScreen(conferenceToEdit: conference),
      ),
    ).then((_) {
      if (mounted) {
        context.read<ConferenceListViewModel>().loadConferences();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conferências')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToRegistration(),
        child: const Icon(Icons.add),
      ),
      body: Consumer<ConferenceListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ConferenceListState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.state == ConferenceListState.error) {
            return Center(
              child: Text(
                viewModel.errorMessage ?? 'Erro ao carregar conferências',
              ),
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
                      _navigateToRegistration(conference: conference);
                    } else if (value == 'delete') {
                      _showDeleteDialog(context, viewModel, conference.id);
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
    ConferenceListViewModel viewModel,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja realmente excluir esta conferência?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              viewModel.deleteConference(id);
              Navigator.pop(dialogContext);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
