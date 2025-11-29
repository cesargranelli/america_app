import 'package:dio/dio.dart';
import '../../domain/models/conference.dart';
import '../../core/exceptions/repository_exception.dart';

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
      return await _dio
          .post('/organizations/conference', data: conference.toJson())
          .then((response) {
            return Conference.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar conferência no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar a conferência. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Conference>> getAll() async {
    try {
      return await _dio.get('/organizations/conference').then((response) {
        return (response.data as List)
            .map((e) => Conference.fromJson(e))
            .toList();
      });
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> update(Conference conference) async {
    try {
      await _dio.put(
        '/organizations/conference/${conference.id}',
        data: conference.toJson(),
      );
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar conferência.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/conference/$id');
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar conferência.');
    }
  }
}
