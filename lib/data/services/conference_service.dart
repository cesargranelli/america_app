import 'package:dio/dio.dart';
import '../../domain/models/conference.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class ConferenceService {
  Future<Conference> register(Conference conference);
  Future<List<Conference>> getAll();
  Future<void> update(Conference conference);
  Future<void> delete(String id);
}

class ConferenceServiceImpl implements ConferenceService {
  final Dio _dio;

  ConferenceServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Conference> register(Conference conference) async {
    try {
      final response = await _dio.post(
        '/organizations/conference',
        data: conference.toJson(),
      );
      return Conference.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar conferência no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar a conferência. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de conferência',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Conference>> getAll() async {
    try {
      final response = await _dio.get('/organizations/conference');
      return (response.data as List)
          .map((e) => Conference.fromJson(e))
          .toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar conferências', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar conferências.');
    }
  }

  @override
  Future<void> update(Conference conference) async {
    try {
      await _dio.put(
        '/organizations/conference/${conference.id}',
        data: conference.toJson(),
      );
    } catch (e, s) {
      AppLogger.error('Erro ao atualizar conferência', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar conferência.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/conference/$id');
    } catch (e, s) {
      AppLogger.error('Erro ao deletar conferência', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar conferência.');
    }
  }
}
