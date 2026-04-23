import 'package:dio/dio.dart';
import '../../domain/models/team.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class TeamService {
  Future<Team> register(Team team);
  Future<List<Team>> getAll();
  Future<void> update(Team team);
  Future<void> delete(String id);
}

class TeamServiceImpl implements TeamService {
  final Dio _dio;

  TeamServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Team> register(Team team) async {
    try {
      final response = await _dio.post(
        '/organizations/team',
        data: team.toJson(),
      );
      return Team.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar time no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar o time. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de time',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Team>> getAll() async {
    try {
      final response = await _dio.get('/organizations/team');
      return (response.data as List).map((e) => Team.fromJson(e)).toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar times', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar times.');
    }
  }

  @override
  Future<void> update(Team team) async {
    try {
      await _dio.put('/organizations/team/${team.id}', data: team.toJson());
    } catch (e, s) {
      AppLogger.error('Erro ao atualizar time', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar time.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/team/$id');
    } catch (e, s) {
      AppLogger.error('Erro ao deletar time', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar time.');
    }
  }
}
