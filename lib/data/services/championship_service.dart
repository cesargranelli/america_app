import 'package:dio/dio.dart';
import '../../domain/models/championship.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

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
      final response = await _dio.post(
        '/organizations/championship',
        data: championship.toJson(),
      );
      return Championship.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar campeonato no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar o campeonato. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de campeonato',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Championship>> getAll() async {
    try {
      final response = await _dio.get('/organizations/championship');
      return (response.data as List)
          .map((e) => Championship.fromJson(e))
          .toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar campeonatos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar campeonatos.');
    }
  }

  @override
  Future<void> update(Championship championship) async {
    try {
      await _dio.put(
        '/organizations/championship/${championship.id}',
        data: championship.toJson(),
      );
    } catch (e, s) {
      AppLogger.error('Erro ao atualizar campeonato', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar campeonato.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/championship/$id');
    } catch (e, s) {
      AppLogger.error('Erro ao deletar campeonato', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar campeonato.');
    }
  }
}
