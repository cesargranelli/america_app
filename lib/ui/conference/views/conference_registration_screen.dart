import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/conference.dart';
import '../view_models/conference_registration_view_model.dart';

class ConferenceRegistrationScreen extends StatelessWidget {
  final ConferenceRegistrationViewModel? viewModel;
  final Conference? conferenceToEdit;

  const ConferenceRegistrationScreen({
    super.key,
    this.viewModel,
    this.conferenceToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _ConferenceRegistrationView(conferenceToEdit: conferenceToEdit),
      );
    } else {
      return _ConferenceRegistrationView(conferenceToEdit: conferenceToEdit);
    }
  }
}

class _ConferenceRegistrationView extends StatefulWidget {
  final Conference? conferenceToEdit;

  const _ConferenceRegistrationView({this.conferenceToEdit});

  @override
  State<_ConferenceRegistrationView> createState() =>
      _ConferenceRegistrationViewState();
}

class _ConferenceRegistrationViewState
    extends State<_ConferenceRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  String? _selectedChampionshipId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ConferenceRegistrationViewModel>().loadChampionships();
    });

    if (widget.conferenceToEdit != null) {
      final c = widget.conferenceToEdit!;
      _nameCtrl.text = c.name;
      _selectedChampionshipId = c.championshipId;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConferenceRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading =
            viewModel.state == ConferenceRegistrationState.loading;
        final isEditing = widget.conferenceToEdit != null;

        if (viewModel.state == ConferenceRegistrationState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing
                      ? 'Conferência atualizada!'
                      : 'Conferência registrada!',
                ),
              ),
            );
            Navigator.of(context).pop();
          });
        } else if (viewModel.state == ConferenceRegistrationState.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(viewModel.errorMessage ?? 'Erro desconhecido'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEditing ? 'Editar Conferência' : 'Cadastro de Conferência',
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Campeonato',
                      ),
                      initialValue: _selectedChampionshipId,
                      items: viewModel.championships.map((championship) {
                        return DropdownMenuItem(
                          value: championship.id,
                          child: Text(championship.name),
                        );
                      }).toList(),
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedChampionshipId = value;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione um campeonato';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                if (isEditing) {
                                  viewModel.updateConference(
                                    id: widget.conferenceToEdit!.id,
                                    name: _nameCtrl.text,
                                    championshipId: _selectedChampionshipId!,
                                  );
                                } else {
                                  viewModel.registerConference(
                                    name: _nameCtrl.text,
                                    championshipId: _selectedChampionshipId!,
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFFFAC638),
                        foregroundColor: const Color(0xFF4A4A4A),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Text(isEditing ? 'Atualizar' : 'Registrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
