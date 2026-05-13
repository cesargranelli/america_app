import 'package:flutter/material.dart';

import '../../../data/repositories/championship_repository.dart';
import '../../../domain/models/championship.dart';

enum ChampionshipRegistrationState { initial, loading, success, error }

class ChampionshipRegistrationViewModel extends ChangeNotifier {
  final ChampionshipRepository _championshipRepository;

  ChampionshipRegistrationViewModel({
    required ChampionshipRepository championshipRepository,
  }) : _championshipRepository = championshipRepository;

  ChampionshipRegistrationState _state = ChampionshipRegistrationState.initial;

  ChampionshipRegistrationState get state => _state;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> registerChampionship({
    required String name,
    required String season,
    required String startDate,
    required String endDate,
    required String leagueId,
  }) async {
    _updateState(ChampionshipRegistrationState.loading);

    try {
      final championship = Championship(
        id: '',
        name: name,
        season: season,
        startDate: startDate,
        endDate: endDate,
        leagueId: leagueId,
      );

      await _championshipRepository.registerChampionship(championship);
      _updateState(ChampionshipRegistrationState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _updateState(ChampionshipRegistrationState.error);
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateChampionship({
    required String id,
    required String name,
    required String season,
    required String startDate,
    required String endDate,
    required String leagueId,
  }) async {
    _updateState(ChampionshipRegistrationState.loading);

    try {
      final championship = Championship(
        id: id,
        name: name,
        season: season,
        startDate: startDate,
        endDate: endDate,
        leagueId: leagueId,
      );

      await _championshipRepository.updateChampionship(championship);
      _updateState(ChampionshipRegistrationState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _updateState(ChampionshipRegistrationState.error);
    } finally {
      notifyListeners();
    }
  }

  void _updateState(ChampionshipRegistrationState newState) {
    _state = newState;
    notifyListeners();
  }
}
