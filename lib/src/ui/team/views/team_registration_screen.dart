import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/team.dart';
import '../view_models/team_registration_view_model.dart';

class TeamRegistrationScreen extends StatelessWidget {
  final TeamRegistrationViewModel? viewModel;
  final Team? teamToEdit;

  const TeamRegistrationScreen({
    super.key,
    this.viewModel,
    this.teamToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _TeamRegistrationView(teamToEdit: teamToEdit),
      );
    } else {
      return _TeamRegistrationView(teamToEdit: teamToEdit);
    }
  }
}

class _TeamRegistrationView extends StatefulWidget {
  final Team? teamToEdit;

  const _TeamRegistrationView({this.teamToEdit});

  @override
  State<_TeamRegistrationView> createState() =>
      _TeamRegistrationViewState();
}

class _TeamRegistrationViewState
    extends State<_TeamRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  String? _selectedDivisionId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeamRegistrationViewModel>().loadDivisions();
    });

    if (widget.teamToEdit != null) {
      final t = widget.teamToEdit!;
      _nameCtrl.text = t.name;
      _cityCtrl.text = t.city;
      _selectedDivisionId = t.divisionId;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading =
            viewModel.state == TeamRegistrationState.loading;
        final isEditing = widget.teamToEdit != null;

        if (viewModel.state == TeamRegistrationState.success) {
           WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(isEditing ? 'Time atualizado!' : 'Time registrado!')),
            );
            Navigator.of(context).pop();
          });
        } else if (viewModel.state == TeamRegistrationState.error) {
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
            title: Text(isEditing ? 'Editar Time' : 'Cadastro de Time'),
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
                      controller: _cityCtrl,
                      decoration: const InputDecoration(labelText: 'Cidade'),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a cidade';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Divisão'),
                      value: _selectedDivisionId,
                      items: viewModel.divisions.map((division) {
                        return DropdownMenuItem(
                          value: division.id,
                          child: Text(division.name),
                        );
                      }).toList(),
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedDivisionId = value;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione uma divisão';
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
                                  viewModel.updateTeam(
                                    id: widget.teamToEdit!.id,
                                    name: _nameCtrl.text,
                                    city: _cityCtrl.text,
                                    divisionId: _selectedDivisionId!,
                                  );
                                } else {
                                  viewModel.registerTeam(
                                    name: _nameCtrl.text,
                                    city: _cityCtrl.text,
                                    divisionId: _selectedDivisionId!,
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
