import 'package:dio/dio.dart';
import '../../domain/models/team.dart';
import '../../core/exceptions/repository_exception.dart';

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
      return await _dio
          .post('/organizations/team', data: team.toJson())
          .then((response) {
            return Team.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar time no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar o time. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Team>> getAll() async {
    try {
      return await _dio.get('/organizations/team').then((response) {
        return (response.data as List)
            .map((e) => Team.fromJson(e))
            .toList();
      });
    } catch (e) {
       return [];
    }
  }

  @override
  Future<void> update(Team team) async {
    try {
      await _dio.put('/organizations/team/${team.id}', data: team.toJson());
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar time.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/team/$id');
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar time.');
    }
  }
}
