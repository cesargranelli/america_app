import 'package:flutter/material.dart';
import '../../../data/repositories/division_repository.dart';
import '../../../data/repositories/conference_repository.dart';
import '../../../domain/models/division.dart';
import '../../../domain/models/conference.dart';

enum DivisionRegistrationState { initial, loading, success, error }

class DivisionRegistrationViewModel extends ChangeNotifier {
  final DivisionRepository _divisionRepository;
  final ConferenceRepository _conferenceRepository;

  DivisionRegistrationViewModel({
    required DivisionRepository divisionRepository,
    required ConferenceRepository conferenceRepository,
  })  : _divisionRepository = divisionRepository,
        _conferenceRepository = conferenceRepository;

  DivisionRegistrationState _state = DivisionRegistrationState.initial;
  DivisionRegistrationState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Conference> _conferences = [];
  List<Conference> get conferences => _conferences;

  Future<void> loadConferences() async {
    try {
      _conferences = await _conferenceRepository.getAllConferences();
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar conferências: $e');
    }
  }

  Future<void> registerDivision({
    required String name,
    required String conferenceId,
  }) async {
    _state = DivisionRegistrationState.loading;
    notifyListeners();

    try {
      final division = Division(
        id: '',
        name: name,
        conferenceId: conferenceId,
      );

      await _divisionRepository.registerDivision(division);
      _state = DivisionRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = DivisionRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateDivision({
    required String id,
    required String name,
    required String conferenceId,
  }) async {
    _state = DivisionRegistrationState.loading;
    notifyListeners();

    try {
      final division = Division(
        id: id,
        name: name,
        conferenceId: conferenceId,
      );

      await _divisionRepository.updateDivision(division);
      _state = DivisionRegistrationState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = DivisionRegistrationState.error;
    } finally {
      notifyListeners();
    }
  }
}
