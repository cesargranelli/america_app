import 'package:flutter/material.dart';
import '../../../data/repositories/athlete_repository.dart';
import '../../../data/repositories/team_repository.dart';
import '../../../domain/models/athlete.dart';
import '../../../domain/models/team.dart';
import '../../core/utils/app_logger.dart';

enum AthleteRegistrationState { initial, loading, success, error }

class AthleteRegistrationViewModel extends ChangeNotifier {
  final AthleteRepository _athleteRepository;
  final TeamRepository _teamRepository;

  AthleteRegistrationViewModel({
    required AthleteRepository athleteRepository,
    required TeamRepository teamRepository,
  }) : _athleteRepository = athleteRepository,
       _teamRepository = teamRepository;

  AthleteRegistrationState _state = AthleteRegistrationState.initial;
  AthleteRegistrationState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Team> _teams = [];
  List<Team> get teams => _teams;

  Future<void> loadTeams() async {
    try {
      _teams = await _teamRepository.getAllTeams();
      notifyListeners();
    } catch (e) {
      AppLogger.error('Erro ao carregar times', error: e);
    }
  }

  Future<void> registerAthlete({
    required String name,
    required String position,
    required String teamId,
  }) async {
    _state = AthleteRegistrationState.loading;
    notifyListeners();

    try {
      final athlete = Athlete(
        id: '',
        name: name,
        position: position,
        teamId: teamId,
      );

      await _athleteRepository.registerAthlete(athlete);
      _state = AthleteRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = AthleteRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateAthlete({
    required String id,
    required String name,
    required String position,
    required String teamId,
  }) async {
    _state = AthleteRegistrationState.loading;
    notifyListeners();

    try {
      final athlete = Athlete(
        id: id,
        name: name,
        position: position,
        teamId: teamId,
      );

      await _athleteRepository.updateAthlete(athlete);
      _state = AthleteRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = AthleteRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }
}
