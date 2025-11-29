import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/division.dart';
import '../view_models/division_registration_view_model.dart';

class DivisionRegistrationScreen extends StatelessWidget {
  final DivisionRegistrationViewModel? viewModel;
  final Division? divisionToEdit;

  const DivisionRegistrationScreen({
    super.key,
    this.viewModel,
    this.divisionToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _DivisionRegistrationView(divisionToEdit: divisionToEdit),
      );
    } else {
      return _DivisionRegistrationView(divisionToEdit: divisionToEdit);
    }
  }
}

class _DivisionRegistrationView extends StatefulWidget {
  final Division? divisionToEdit;

  const _DivisionRegistrationView({this.divisionToEdit});

  @override
  State<_DivisionRegistrationView> createState() =>
      _DivisionRegistrationViewState();
}

class _DivisionRegistrationViewState extends State<_DivisionRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  String? _selectedConferenceId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DivisionRegistrationViewModel>().loadConferences();
    });

    if (widget.divisionToEdit != null) {
      final d = widget.divisionToEdit!;
      _nameCtrl.text = d.name;
      _selectedConferenceId = d.conferenceId;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DivisionRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading = viewModel.state == DivisionRegistrationState.loading;
        final isEditing = widget.divisionToEdit != null;

        if (viewModel.state == DivisionRegistrationState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing ? 'Divisão atualizada!' : 'Divisão registrada!',
                ),
              ),
            );
            Navigator.of(context).pop();
          });
        } else if (viewModel.state == DivisionRegistrationState.error) {
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
            title: Text(isEditing ? 'Editar Divisão' : 'Cadastro de Divisão'),
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
                        labelText: 'Conferência',
                      ),
                      initialValue: _selectedConferenceId,
                      items: viewModel.conferences.map((conference) {
                        return DropdownMenuItem(
                          value: conference.id,
                          child: Text(conference.name),
                        );
                      }).toList(),
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedConferenceId = value;
                              });
                            },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione uma conferência';
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
                                  viewModel.updateDivision(
                                    id: widget.divisionToEdit!.id,
                                    name: _nameCtrl.text,
                                    conferenceId: _selectedConferenceId!,
                                  );
                                } else {
                                  viewModel.registerDivision(
                                    name: _nameCtrl.text,
                                    conferenceId: _selectedConferenceId!,
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
