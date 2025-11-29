import 'package:flutter/material.dart';
import '../../../data/repositories/play_repository.dart';
import '../../../domain/models/play.dart';

enum GameTimelineState { initial, loading, success, error }

class GameTimelineViewModel extends ChangeNotifier {
  final PlayRepository _playRepository;

  GameTimelineViewModel({required PlayRepository playRepository})
    : _playRepository = playRepository;

  GameTimelineState _state = GameTimelineState.initial;
  GameTimelineState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Play> _plays = [];
  List<Play> get plays => _plays;

  Future<void> loadPlays(String gameId) async {
    _state = GameTimelineState.loading;
    notifyListeners();
    try {
      _plays = await _playRepository.getPlaysByGameId(gameId);
      _state = GameTimelineState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = GameTimelineState.error;
    } finally {
      notifyListeners();
    }
  }
}
