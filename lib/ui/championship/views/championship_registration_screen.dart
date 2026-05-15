import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/championship.dart';
import '../../../domain/models/league.dart';
import '../../core/theme/app_theme.dart';
import '../view_models/championship_registration_view_model.dart';

class ChampionshipRegistrationScreen extends StatelessWidget {
  final ChampionshipRegistrationViewModel? viewModel;
  final League? league;
  final Championship? championshipToEdit;

  const ChampionshipRegistrationScreen({
    super.key,
    this.viewModel,
    this.league,
    this.championshipToEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: _ChampionshipRegistrationView(
          league: league,
          championshipToEdit: championshipToEdit,
        ),
      );
    } else {
      return _ChampionshipRegistrationView(
        league: league,
        championshipToEdit: championshipToEdit,
      );
    }
  }
}

class _ChampionshipRegistrationView extends StatefulWidget {
  final League? league;
  final Championship? championshipToEdit;

  const _ChampionshipRegistrationView({this.championshipToEdit, this.league});

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

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.onSurface),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDateCtrl.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.onSurface),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endDateCtrl.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
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
          });
          Navigator.of(context).pop();
        } else if (viewModel.state == ChampionshipRegistrationState.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(viewModel.errorMessage ?? 'Erro desconhecido'),
                backgroundColor: Colors.red,
              ),
            );
          });
          Navigator.of(context).pop();
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
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Data de Abertura',
                        hintText: 'Selecione a data de abertura',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.accent,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => _selectStartDate(context),
                        ),
                      ),
                      onTap: isLoading ? null : () => _selectStartDate(context),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _endDateCtrl,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Data de Encerramento',
                        hintText: 'Selecione a data de encerramento',
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.accent,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => _selectEndDate(context),
                        ),
                      ),
                      onTap: isLoading ? null : () => _selectEndDate(context),
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
                                    leagueId: widget.league!.id,
                                  );
                                } else {
                                  viewModel.registerChampionship(
                                    name: _nameCtrl.text,
                                    season: _seasonCtrl.text,
                                    startDate: _startDateCtrl.text,
                                    endDate: _endDateCtrl.text,
                                    leagueId: widget.league!.id,
                                  );
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(),
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
