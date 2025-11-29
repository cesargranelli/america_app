import 'package:flutter/material.dart';
import '../../../data/repositories/athlete_repository.dart';
import '../../../domain/models/athlete.dart';

enum AthleteListState { initial, loading, success, error }

class AthleteListViewModel extends ChangeNotifier {
  final AthleteRepository _athleteRepository;

  AthleteListViewModel({required AthleteRepository athleteRepository})
    : _athleteRepository = athleteRepository;

  AthleteListState _state = AthleteListState.initial;
  AthleteListState get state => _state;

  List<Athlete> _athletes = [];
  List<Athlete> get athletes => _athletes;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadAthletes() async {
    _state = AthleteListState.loading;
    notifyListeners();

    try {
      _athletes = await _athleteRepository.getAllAthletes();
      _state = AthleteListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = AthleteListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteAthlete(String id) async {
    try {
      await _athleteRepository.deleteAthlete(id);
      _athletes.removeWhere((a) => a.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = AthleteListState.error;
      notifyListeners();
    }
  }
}
