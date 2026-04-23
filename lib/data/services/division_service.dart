import 'package:dio/dio.dart';
import '../../domain/models/division.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class DivisionService {
  Future<Division> register(Division division);
  Future<List<Division>> getAll();
  Future<void> update(Division division);
  Future<void> delete(String id);
}

class DivisionServiceImpl implements DivisionService {
  final Dio _dio;

  DivisionServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Division> register(Division division) async {
    try {
      final response = await _dio.post(
        '/organizations/division',
        data: division.toJson(),
      );
      return Division.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar divisão no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar a divisão. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de divisão',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Division>> getAll() async {
    try {
      final response = await _dio.get('/organizations/division');
      return (response.data as List).map((e) => Division.fromJson(e)).toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar divisões', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar divisões.');
    }
  }

  @override
  Future<void> update(Division division) async {
    try {
      await _dio.put(
        '/organizations/division/${division.id}',
        data: division.toJson(),
      );
    } catch (e, s) {
      AppLogger.error('Erro ao atualizar divisão', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao atualizar divisão.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/division/$id');
    } catch (e, s) {
      AppLogger.error('Erro ao deletar divisão', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar divisão.');
    }
  }
}
