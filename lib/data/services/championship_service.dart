import 'package:dio/dio.dart';
import '../../domain/models/championship.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class ChampionshipService {
  Future<Championship> register(Championship championship);
  Future<List<Championship>> getAll();
  Future<void> update(Championship championship);
  Future<void> delete(String id);
}

class ChampionshipServiceImpl implements ChampionshipService {
  final Dio _dio;

  ChampionshipServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Championship> register(Championship championship) async {
    try {
      return await _dio
          .post('/organizations/championship', data: championship.toJson())
          .then((response) {
            return Championship.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar campeonato no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar o campeonato. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Championship>> getAll() async {
    try {
      return await _dio.get('/organizations/championship').then((response) {
        return (response.data as List)
            .map((e) => Championship.fromJson(e))
            .toList();
      });
    } catch (e) {
      // Return empty list for now if API fails or is not implemented
      return [];
    }
  }

  @override
  Future<void> update(Championship championship) async {
    try {
      await _dio.put(
        '/organizations/championship/${championship.id}',
        data: championship.toJson(),
      );
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar campeonato.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/championship/$id');
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar campeonato.');
    }
  }
}
