import 'package:flutter/material.dart';
import '../../../data/repositories/team_repository.dart';
import '../../../data/repositories/division_repository.dart';
import '../../../domain/models/team.dart';
import '../../../domain/models/division.dart';
import '../../core/utils/app_logger.dart';

enum TeamRegistrationState { initial, loading, success, error }

class TeamRegistrationViewModel extends ChangeNotifier {
  final TeamRepository _teamRepository;
  final DivisionRepository _divisionRepository;

  TeamRegistrationViewModel({
    required TeamRepository teamRepository,
    required DivisionRepository divisionRepository,
  }) : _teamRepository = teamRepository,
       _divisionRepository = divisionRepository;

  TeamRegistrationState _state = TeamRegistrationState.initial;
  TeamRegistrationState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Division> _divisions = [];
  List<Division> get divisions => _divisions;

  Future<void> loadDivisions() async {
    try {
      _divisions = await _divisionRepository.getAllDivisions();
      notifyListeners();
    } catch (e) {
      AppLogger.error('Erro ao carregar divisões', error: e);
    }
  }

  Future<void> registerTeam({
    required String name,
    required String city,
    required String divisionId,
  }) async {
    _state = TeamRegistrationState.loading;
    notifyListeners();

    try {
      final team = Team(id: '', name: name, city: city, divisionId: divisionId);

      await _teamRepository.registerTeam(team);
      _state = TeamRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = TeamRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTeam({
    required String id,
    required String name,
    required String city,
    required String divisionId,
  }) async {
    _state = TeamRegistrationState.loading;
    notifyListeners();

    try {
      final team = Team(id: id, name: name, city: city, divisionId: divisionId);

      await _teamRepository.updateTeam(team);
      _state = TeamRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = TeamRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }
}
