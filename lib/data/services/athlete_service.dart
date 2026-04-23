import 'package:dio/dio.dart';
import '../../domain/models/athlete.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class AthleteService {
  Future<Athlete> register(Athlete athlete);
  Future<List<Athlete>> getAll();
  Future<void> update(Athlete athlete);
  Future<void> delete(String id);
}

class AthleteServiceImpl implements AthleteService {
  final Dio _dio;

  AthleteServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Athlete> register(Athlete athlete) async {
    try {
      final response = await _dio.post(
        '/organizations/athlete',
        data: athlete.toJson(),
      );
      return Athlete.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar atleta no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar o atleta. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de atleta',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Athlete>> getAll() async {
    try {
      final response = await _dio.get('/organizations/athlete');
      return (response.data as List).map((e) => Athlete.fromJson(e)).toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar atletas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar atletas.');
    }
  }

  @override
  Future<void> update(Athlete athlete) async {
    try {
      await _dio.put(
        '/organizations/athlete/${athlete.id}',
        data: athlete.toJson(),
      );
    } catch (e, s) {
      AppLogger.error('Erro ao atualizar atleta', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar atleta.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/athlete/$id');
    } catch (e, s) {
      AppLogger.error('Erro ao deletar atleta', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar atleta.');
    }
  }
}
