import 'package:flutter/material.dart';

import '../../../data/repositories/championship_repository.dart';
import '../../../domain/models/championship.dart';
import '../../../domain/models/league.dart';

enum LeagueState { initial, loading, success, error }

class LeagueViewModel extends ChangeNotifier {
  final ChampionshipRepository _championshipRepository;

  LeagueViewModel({required ChampionshipRepository championshipRepository})
    : _championshipRepository = championshipRepository;

  LeagueState _state = LeagueState.initial;

  LeagueState get state => _state;

  List<Championship> _championships = [];

  List<Championship> get championships => _championships;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loadChampionships(League league) async {
    _state = LeagueState.loading;
    notifyListeners();

    try {
      _championships = await _championshipRepository.getChampionships(league);
      _state = LeagueState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = LeagueState.error;
    } finally {
      notifyListeners();
    }
  }
}
