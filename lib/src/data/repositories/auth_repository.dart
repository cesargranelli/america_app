import '../../domain/models/user_model.dart';
import '../services/auth_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);
  Future<UserModel?> signUp(String email, String password, String name);
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl({required AuthService authService})
      : _authService = authService;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    try {
      return await _authService.signIn(email, password);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao fazer login: $e');
    }
  }

  @override
  Future<UserModel?> signUp(String email, String password, String name) async {
    try {
      return await _authService.signUp(email, password, name);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao registrar usuário: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw RepositoryException(message: 'Erro ao fazer logout: $e');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges => _authService.authStateChanges;
}
