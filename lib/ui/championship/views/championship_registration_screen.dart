import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/championship.dart';
import '../view_models/championship_registration_view_model.dart';

class ChampionshipRegistrationScreen extends StatelessWidget {
  final ChampionshipRegistrationViewModel? viewModel;
  final Championship? championshipToEdit;

  const ChampionshipRegistrationScreen({
    super.key,
    this.viewModel,
    this.championshipToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _ChampionshipRegistrationView(
          championshipToEdit: championshipToEdit,
        ),
      );
    } else {
      return _ChampionshipRegistrationView(
        championshipToEdit: championshipToEdit,
      );
    }
  }
}

class _ChampionshipRegistrationView extends StatefulWidget {
  final Championship? championshipToEdit;

  const _ChampionshipRegistrationView({this.championshipToEdit});

  @override
  State<_ChampionshipRegistrationView> createState() =>
      _ChampionshipRegistrationViewState();
}

class _ChampionshipRegistrationViewState
    extends State<_ChampionshipRegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _seasonCtrl = TextEditingController();
  final TextEditingController _startDateCtrl = TextEditingController();
  final TextEditingController _endDateCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.championshipToEdit != null) {
      final c = widget.championshipToEdit!;
      _nameCtrl.text = c.name;
      _seasonCtrl.text = c.season;
      _startDateCtrl.text = c.startDate;
      _endDateCtrl.text = c.endDate;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _seasonCtrl.dispose();
    _startDateCtrl.dispose();
    _endDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChampionshipRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading =
            viewModel.state == ChampionshipRegistrationState.loading;
        final isEditing = widget.championshipToEdit != null;

        if (viewModel.state == ChampionshipRegistrationState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditing
                      ? 'Campeonato atualizado!'
                      : 'Campeonato registrado!',
                ),
              ),
            );
            Navigator.of(context).pop();
          });
        } else if (viewModel.state == ChampionshipRegistrationState.error) {
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
              isEditing ? 'Editar Campeonato' : 'Cadastro de Campeonato',
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
                    TextFormField(
                      controller: _seasonCtrl,
                      decoration: const InputDecoration(labelText: 'Temporada'),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a temporada';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _startDateCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Data de Início',
                      ),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a data de início';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _endDateCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Data de Término',
                      ),
                      enabled: !isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira a data de término';
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
                                  viewModel.updateChampionship(
                                    id: widget.championshipToEdit!.id,
                                    name: _nameCtrl.text,
                                    season: _seasonCtrl.text,
                                    startDate: _startDateCtrl.text,
                                    endDate: _endDateCtrl.text,
                                  );
                                } else {
                                  viewModel.registerChampionship(
                                    name: _nameCtrl.text,
                                    season: _seasonCtrl.text,
                                    startDate: _startDateCtrl.text,
                                    endDate: _endDateCtrl.text,
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
