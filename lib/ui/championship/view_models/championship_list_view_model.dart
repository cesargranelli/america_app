import 'package:flutter/material.dart';

import '../../../data/repositories/championship_repository.dart';
import '../../../domain/models/championship.dart';

enum ChampionshipListState { initial, loading, success, error }

class ChampionshipListViewModel extends ChangeNotifier {
  final ChampionshipRepository _championshipRepository;

  ChampionshipListViewModel({
    required ChampionshipRepository championshipRepository,
  }) : _championshipRepository = championshipRepository;

  ChampionshipListState _state = ChampionshipListState.initial;

  ChampionshipListState get state => _state;

  List<Championship> _championships = [];

  List<Championship> get championships => _championships;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> loadChampionships() async {
    _state = ChampionshipListState.loading;
    notifyListeners();

    try {
      _championships = await _championshipRepository.getAllChampionships();
      _state = ChampionshipListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ChampionshipListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteChampionship(String id) async {
    try {
      await _championshipRepository.deleteChampionship(id);
      _championships.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = ChampionshipListState.error;
      notifyListeners();
    }
  }
}
