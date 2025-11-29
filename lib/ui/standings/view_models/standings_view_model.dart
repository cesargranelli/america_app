import 'package:flutter/material.dart';
import '../../../data/repositories/standing_repository.dart';
import '../../../domain/models/standing.dart';

enum StandingsState { initial, loading, success, error }

class StandingsViewModel extends ChangeNotifier {
  final StandingRepository _standingRepository;

  StandingsViewModel({required StandingRepository standingRepository})
    : _standingRepository = standingRepository;

  StandingsState _state = StandingsState.initial;
  StandingsState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Standing> _standings = [];
  List<Standing> get standings => _standings;

  Future<void> loadStandings(String championshipId) async {
    _state = StandingsState.loading;
    notifyListeners();
    try {
      _standings = await _standingRepository.getStandings(championshipId);
      _state = StandingsState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = StandingsState.error;
    } finally {
      notifyListeners();
    }
  }
}
