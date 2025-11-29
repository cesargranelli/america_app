import 'package:flutter/material.dart';
import '../../../data/repositories/conference_repository.dart';
import '../../../domain/models/conference.dart';

enum ConferenceListState { initial, loading, success, error }

class ConferenceListViewModel extends ChangeNotifier {
  final ConferenceRepository _conferenceRepository;

  ConferenceListViewModel({required ConferenceRepository conferenceRepository})
    : _conferenceRepository = conferenceRepository;

  ConferenceListState _state = ConferenceListState.initial;
  ConferenceListState get state => _state;

  List<Conference> _conferences = [];
  List<Conference> get conferences => _conferences;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadConferences() async {
    _state = ConferenceListState.loading;
    notifyListeners();

    try {
      _conferences = await _conferenceRepository.getAllConferences();
      _state = ConferenceListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ConferenceListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteConference(String id) async {
    try {
      await _conferenceRepository.deleteConference(id);
      _conferences.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = ConferenceListState.error;
      notifyListeners();
    }
  }
}
