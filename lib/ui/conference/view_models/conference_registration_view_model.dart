import 'package:flutter/material.dart';
import '../../../data/repositories/conference_repository.dart';
import '../../../data/repositories/championship_repository.dart';
import '../../../domain/models/conference.dart';
import '../../../domain/models/championship.dart';

enum ConferenceRegistrationState { initial, loading, success, error }

class ConferenceRegistrationViewModel extends ChangeNotifier {
  final ConferenceRepository _conferenceRepository;
  final ChampionshipRepository _championshipRepository;

  ConferenceRegistrationViewModel({
    required ConferenceRepository conferenceRepository,
    required ChampionshipRepository championshipRepository,
  }) : _conferenceRepository = conferenceRepository,
       _championshipRepository = championshipRepository;

  ConferenceRegistrationState _state = ConferenceRegistrationState.initial;
  ConferenceRegistrationState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Championship> _championships = [];
  List<Championship> get championships => _championships;

  Future<void> loadChampionships() async {
    try {
      _championships = await _championshipRepository.getAllChampionships();
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar campeonatos: $e');
    }
  }

  Future<void> registerConference({
    required String name,
    required String championshipId,
  }) async {
    _state = ConferenceRegistrationState.loading;
    notifyListeners();

    try {
      final conference = Conference(
        id: '',
        name: name,
        championshipId: championshipId,
      );

      await _conferenceRepository.registerConference(conference);
      _state = ConferenceRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ConferenceRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateConference({
    required String id,
    required String name,
    required String championshipId,
  }) async {
    _state = ConferenceRegistrationState.loading;
    notifyListeners();

    try {
      final conference = Conference(
        id: id,
        name: name,
        championshipId: championshipId,
      );

      await _conferenceRepository.updateConference(conference);
      _state = ConferenceRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ConferenceRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }
}
