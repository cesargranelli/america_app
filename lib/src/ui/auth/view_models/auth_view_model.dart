import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/models/user_model.dart';

enum AuthState { initial, loading, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  AuthState _state = AuthState.initial;
  AuthState get state => _state;

  UserModel? _user;
  UserModel? get user => _user;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Stream<UserModel?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signIn(String email, String password) async {
    _setState(AuthState.loading);
    try {
      _user = await _authRepository.signIn(email, password);
      _setState(AuthState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AuthState.error);
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    _setState(AuthState.loading);
    try {
      _user = await _authRepository.signUp(email, password, name);
      _setState(AuthState.success);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(AuthState.error);
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    _user = null;
    notifyListeners();
  }

  void _setState(AuthState state) {
    _state = state;
    notifyListeners();
  }
}
