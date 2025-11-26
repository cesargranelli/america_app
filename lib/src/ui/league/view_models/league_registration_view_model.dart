import 'package:flutter/material.dart';

import '../../../data/models/league_registration_model.dart';
import '../../../data/repositories/league_repository.dart';

// Enum para gerenciar os diferentes estados da tela
enum LeagueRegistrationState { initial, loading, success, error }

class LeagueRegistrationViewModel with ChangeNotifier {
  final LeagueRepository _leagueRepository;

  LeagueRegistrationViewModel({required LeagueRepository leagueRepository})
    : _leagueRepository = leagueRepository;

  // Gerenciamento de estado
  var _state = LeagueRegistrationState.initial;

  LeagueRegistrationState get state => _state;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // Método de negócio principal
  Future<void> registerLeague({
    required String name,
    required String acronym,
    required String foundationDate, // Formato DD/MM/YYYY
  }) async {
    _updateState(LeagueRegistrationState.loading);

    try {
      // 1. Validação dos dados de entrada
      if (name.isEmpty || acronym.isEmpty || foundationDate.isEmpty) {
        throw Exception('Todos os campos são obrigatórios.');
      }

      // 2. Formatação da data para o formato da API (YYYY-MM-DD)
      final dateParts = foundationDate.split('/');
      if (dateParts.length != 3) {
        throw Exception('Formato de data inválido. Use DD/MM/AAAA.');
      }
      final formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

      // 3. Criação do modelo de dados
      final league = LeagueRegistrationModel(
        name: name,
        acronym: acronym,
        foundationDate: formattedDate,
        organizationCode:
            'org:97a6461e48e7d96ce886952c4ad2b86d', // Código fixo conforme original
      );

      // 4. Chamada ao repositório
      await _leagueRepository.register(league);

      // 5. Atualização do estado para sucesso
      _updateState(LeagueRegistrationState.success);
    } catch (e) {
      // 6. Tratamento de erro e atualização do estado
      _errorMessage = e.toString();
      _updateState(LeagueRegistrationState.error);
    }
  }

  // Helper para atualizar o estado e notificar os listeners (a tela)
  void _updateState(LeagueRegistrationState newState) {
    _state = newState;
    notifyListeners();
  }
}
