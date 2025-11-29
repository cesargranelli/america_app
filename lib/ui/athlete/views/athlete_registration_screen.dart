import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/athlete.dart';
import '../view_models/athlete_registration_view_model.dart';

class AthleteRegistrationScreen extends StatelessWidget {
  final AthleteRegistrationViewModel? viewModel;
  final Athlete? athleteToEdit;

  const AthleteRegistrationScreen({
    super.key,
    this.viewModel,
    this.athleteToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _AthleteRegistrationView(athleteToEdit: athleteToEdit),
      );
    } else {
      return _AthleteRegistrationView(athleteToEdit: athleteToEdit);
    }
  }
}

class _AthleteRegistrationView extends StatefulWidget {
  final Athlete? athleteToEdit;

  const _AthleteRegistrationView({this.athleteToEdit});

  @override
  State<_AthleteRegistrationView> createState() =>
      _AthleteRegistrationViewState();
}

class _AthleteRegistrationViewState extends State<_AthleteRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _positionCtrl = TextEditingController();
  String? _selectedTeamId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AthleteRegistrationViewModel>().loadTeams();
    });

    if (widget.athleteToEdit != null) {
      final a = widget.athleteToEdit!;
      _nameCtrl.text = a.name;
      _positionCtrl.text = a.position;
      _selectedTeamId = a.teamId;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _positionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AthleteRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading = viewModel.state == AthleteRegistrationState.loading;
        final isEditing = widget.athleteToEdit != null;

        if (viewModel.state == AthleteRegistrationState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing ? 'Atleta atualizado!' : 'Atleta registrado!',
                ),
              ),
            );
            Navigator.of(context).pop();
          });
        } else if (viewModel.state == AthleteRegistrationState.error) {
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
            title: Text(isEditing ? 'Editar Atleta' : 'Cadastro de Atleta'),
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
                    TextFormField(
                      controller: _positionCtrl,
                      decoration: const InputDecoration(labelText: 'Posição'),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a posição';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Time'),
                      initialValue: _selectedTeamId,
                      items: viewModel.teams.map((team) {
                        return DropdownMenuItem(
                          value: team.id,
                          child: Text(team.name),
                        );
                      }).toList(),
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedTeamId = value;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione um time';
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
                                  viewModel.updateAthlete(
                                    id: widget.athleteToEdit!.id,
                                    name: _nameCtrl.text,
                                    position: _positionCtrl.text,
                                    teamId: _selectedTeamId!,
                                  );
                                } else {
                                  viewModel.registerAthlete(
                                    name: _nameCtrl.text,
                                    position: _positionCtrl.text,
                                    teamId: _selectedTeamId!,
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
