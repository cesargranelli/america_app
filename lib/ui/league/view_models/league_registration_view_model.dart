import 'package:flutter/material.dart';

import '../../../data/repositories/league_repository.dart';
import '../../../domain/models/league.dart';

enum LeagueRegistrationState { initial, loading, success, error }

class LeagueRegistrationViewModel with ChangeNotifier {
  final LeagueRepository _leagueRepository;

  LeagueRegistrationViewModel({required LeagueRepository leagueRepository})
    : _leagueRepository = leagueRepository;

  LeagueRegistrationState _state = LeagueRegistrationState.initial;

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
      if (name.isEmpty || acronym.isEmpty || foundationDate.isEmpty) {
        throw Exception('Todos os campos são obrigatórios.');
      }

      final dateParts = foundationDate.split('/');
      if (dateParts.length != 3) {
        throw Exception('Formato de data inválido. Use DD/MM/AAAA.');
      }

      final league = League(
        name: name,
        acronym: acronym,
        foundationDate: foundationDate,
      );

      await _leagueRepository.registerLeague(league);

      _updateState(LeagueRegistrationState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _updateState(LeagueRegistrationState.error);
    }
  }

  Future<void> updateLeague({
    required String id,
    required String name,
    required String acronym,
    required String foundationDate,
  }) async {
    _updateState(LeagueRegistrationState.loading);

    try {
      if (name.isEmpty || acronym.isEmpty || foundationDate.isEmpty) {
        throw Exception('Todos os campos são obrigatórios.');
      }

      final dateParts = foundationDate.split('/');
      if (dateParts.length != 3) {
        throw Exception('Formato de data inválido. Use DD/MM/AAAA.');
      }

      final league = League(
        id: id,
        name: name,
        acronym: acronym,
        foundationDate: foundationDate,
      );

      await _leagueRepository.updateLeague(league);

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
