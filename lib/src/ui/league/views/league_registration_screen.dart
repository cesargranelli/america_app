import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/league_registration_view_model.dart';

// A tela agora é um StatelessWidget, pois o estado é gerenciado pelo ViewModel.
// Se precisar de animações ou outros controllers de UI complexos, pode-se
// convertê-la para um StatefulWidget e usar um `Consumer` no método `build`.
class LeagueRegistrationScreen extends StatelessWidget {
  // A tela recebe o ViewModel via construtor, facilitando a injeção de dependência.
  final LeagueRegistrationViewModel viewModel;

  const LeagueRegistrationScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Usamos o ChangeNotifierProvider para disponibilizar o viewModel para a árvore de widgets.
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const _LeagueRegistrationView(),
    );
  }
}

// Widget interno que consome o ViewModel para construir a UI.
class _LeagueRegistrationView extends StatefulWidget {
  const _LeagueRegistrationView();

  @override
  State<_LeagueRegistrationView> createState() =>
      _LeagueRegistrationViewState();
}

class _LeagueRegistrationViewState extends State<_LeagueRegistrationView> {
  // Controllers permanecem aqui, pois controlam o estado local dos campos de texto da UI.
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _acronymCtrl = TextEditingController();
  final TextEditingController _foundationDateCrtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Adicionamos um listener para reagir a estados de sucesso ou erro.
    // O 'context' aqui é seguro de usar pois initState já completou.
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
      // Opcional: navegar para outra tela após o sucesso
      // Navigator.of(context).pop();
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
    // Limpeza dos listeners e controllers para evitar memory leaks.
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
              primary: const Color(0xFFFAC638),
              onPrimary: Colors.white,
              onSurface: const Color(0xFF4A4A4A),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4A4A4A),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // O setState aqui é apropriado, pois atualiza um estado local da UI (o texto do controller).
      setState(() {
        _foundationDateCrtl.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usamos um Consumer para reconstruir o botão quando o estado de 'loading' mudar.
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
                          color: Color(0xFF9E8747),
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
                  ? null // Desabilita o botão durante o carregamento
                  : () {
                      // A única responsabilidade do botão é chamar o método do ViewModel.
                      viewModel.registerLeague(
                        name: _nameCtrl.text,
                        acronym: _acronymCtrl.text,
                        foundationDate: _foundationDateCrtl.text,
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFAC638),
                foregroundColor: const Color(0xFF4A4A4A),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Mostra um indicador de progresso ou o texto, dependendo do estado.
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
