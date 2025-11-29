import 'package:flutter/material.dart';

import '../../../data/repositories/league_repository.dart';
import '../../../domain/models/league_registration_model.dart';

enum LeagueRegistrationState { initial, loading, success, error }

class LeagueRegistrationViewModel with ChangeNotifier {
  final LeagueRepository _leagueRepository;

  LeagueRegistrationViewModel({required LeagueRepository leagueRepository})
    : _leagueRepository = leagueRepository;

  var _state = LeagueRegistrationState.initial;

  LeagueRegistrationState get state => _state;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> registerLeague({
    required String name,
    required String acronym,
    required String foundationDate,
  }) async {
    _updateState(LeagueRegistrationState.loading);

    try {
      // 1. Validação dos dados de entrada
      if (name.isEmpty || acronym.isEmpty || foundationDate.isEmpty) {
        throw Exception('Todos os campos são obrigatórios.');
      }

      final dateParts = foundationDate.split('/');
      if (dateParts.length != 3) {
        throw Exception('Formato de data inválido. Use DD/MM/AAAA.');
      }
      final formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

      final league = LeagueRegistrationModel(
        name: name,
        acronym: acronym,
        foundationDate: formattedDate,
        organizationCode: 'org:97a6461e48e7d96ce886952c4ad2b86d',
      );

      await _leagueRepository.register(league);

      _updateState(LeagueRegistrationState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _updateState(LeagueRegistrationState.error);
    }
  }

  void _updateState(LeagueRegistrationState newState) {
    _state = newState;
    notifyListeners();
  }
}
