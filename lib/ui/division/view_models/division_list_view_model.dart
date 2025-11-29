import 'package:flutter/material.dart';
import '../../../data/repositories/division_repository.dart';
import '../../../domain/models/division.dart';

enum DivisionListState { initial, loading, success, error }

class DivisionListViewModel extends ChangeNotifier {
  final DivisionRepository _divisionRepository;

  DivisionListViewModel({required DivisionRepository divisionRepository})
    : _divisionRepository = divisionRepository;

  DivisionListState _state = DivisionListState.initial;
  DivisionListState get state => _state;

  List<Division> _divisions = [];
  List<Division> get divisions => _divisions;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadDivisions() async {
    _state = DivisionListState.loading;
    notifyListeners();

    try {
      _divisions = await _divisionRepository.getAllDivisions();
      _state = DivisionListState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = DivisionListState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteDivision(String id) async {
    try {
      await _divisionRepository.deleteDivision(id);
      _divisions.removeWhere((d) => d.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _state = DivisionListState.error;
      notifyListeners();
    }
  }
}
