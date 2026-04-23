import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../view_models/league_registration_view_model.dart';

class LeagueRegistrationScreen extends StatelessWidget {
  final LeagueRegistrationViewModel? viewModel;

  const LeagueRegistrationScreen({super.key, this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel != null) {
      return ChangeNotifierProvider.value(
        value: viewModel!,
        child: const _LeagueRegistrationView(),
      );
    }
    return const _LeagueRegistrationView();
  }
}

class _LeagueRegistrationView extends StatefulWidget {
  const _LeagueRegistrationView();

  @override
  State<_LeagueRegistrationView> createState() =>
      _LeagueRegistrationViewState();
}

class _LeagueRegistrationViewState extends State<_LeagueRegistrationView> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _acronymCtrl = TextEditingController();
  final TextEditingController _foundationDateCrtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<LeagueRegistrationViewModel>();
    viewModel.addListener(_onViewModelStateChanged);
  }

  void _onViewModelStateChanged() {
    final viewModel = context.read<LeagueRegistrationViewModel>();
    final state = viewModel.state;

    if (state == LeagueRegistrationState.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Liga registrada com sucesso!')),
      );
    } else if (state == LeagueRegistrationState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            viewModel.errorMessage ?? 'Ocorreu um erro desconhecido.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    context.read<LeagueRegistrationViewModel>().removeListener(
      _onViewModelStateChanged,
    );
    _nameCtrl.dispose();
    _acronymCtrl.dispose();
    _foundationDateCrtl.dispose();
    super.dispose();
  }

  Future<void> _selectFoundingDate(BuildContext context) async {
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
        _foundationDateCrtl.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LeagueRegistrationViewModel>(
      builder: (context, viewModel, child) {
        final isLoading = viewModel.state == LeagueRegistrationState.loading;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Cadastro da Liga'),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite o nome da liga',
                    ),
                    enabled:
                        !isLoading, // Desabilita campos durante o carregamento
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _acronymCtrl,
                    decoration: InputDecoration(
                      labelText: 'Sigla',
                      hintText: 'Digite a sigla da liga',
                    ),
                    enabled: !isLoading,
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _foundationDateCrtl,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Fundação',
                      hintText: 'Selecione a data de fundação',
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.calendar_today,
                          color: AppColors.accent,
                        ),
                        onPressed: isLoading
                            ? null
                            : () => _selectFoundingDate(context),
                      ),
                    ),
                    onTap: isLoading
                        ? null
                        : () => _selectFoundingDate(context),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      viewModel.registerLeague(
                        name: _nameCtrl.text,
                        acronym: _acronymCtrl.text,
                        foundationDate: _foundationDateCrtl.text,
                      );
                    },
              style: ElevatedButton.styleFrom(),
              child: isLoading
                  ? const CircularProgressIndicator(color: Color(0xFF4A4A4A))
                  : const Text('Registrar'),
            ),
          ),
        );
      },
    );
  }
}
