import 'package:flutter/material.dart';

import '../../../data/repositories/league_repository.dart';
import '../../../domain/models/league.dart';

enum LeagueListState { initial, loading, success, error }

class LeagueListViewModel extends ChangeNotifier {
  final LeagueRepository _leagueRepository;

  LeagueListViewModel({required LeagueRepository leagueRepository})
    : _leagueRepository = leagueRepository;

  LeagueListState _state = LeagueListState.initial;

  LeagueListState get state => _state;

  List<League> _leagues = [];

  List<League> get leagues => _leagues;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loadLeagues() async {
    _state = LeagueListState.loading;
    notifyListeners();

    try {
      _leagues = await _leagueRepository.getAllLeagues();
      _state = LeagueListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = LeagueListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteLeague(String id) async {
    try {
      await _leagueRepository.deleteLeague(id);
      _leagues.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = LeagueListState.error;
      notifyListeners();
    }
  }
}
