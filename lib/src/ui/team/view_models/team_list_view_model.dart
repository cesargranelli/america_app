import 'package:flutter/material.dart';
import '../../../data/repositories/team_repository.dart';
import '../../../domain/models/team.dart';

enum TeamListState { initial, loading, success, error }

class TeamListViewModel extends ChangeNotifier {
  final TeamRepository _teamRepository;

  TeamListViewModel({
    required TeamRepository teamRepository,
  }) : _teamRepository = teamRepository;

  TeamListState _state = TeamListState.initial;
  TeamListState get state => _state;

  List<Team> _teams = [];
  List<Team> get teams => _teams;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadTeams() async {
    _state = TeamListState.loading;
    notifyListeners();

    try {
      _teams = await _teamRepository.getAllTeams();
      _state = TeamListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = TeamListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTeam(String id) async {
    try {
      await _teamRepository.deleteTeam(id);
      _teams.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = TeamListState.error;
      notifyListeners();
    }
  }
}
