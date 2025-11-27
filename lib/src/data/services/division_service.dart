import 'package:dio/dio.dart';
import '../../domain/models/division.dart';
import '../../core/exceptions/repository_exception.dart';

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
      return await _dio
          .post('/organizations/division', data: division.toJson())
          .then((response) {
            return Division.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar divisão no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar a divisão. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Division>> getAll() async {
    try {
      return await _dio.get('/organizations/division').then((response) {
        return (response.data as List)
            .map((e) => Division.fromJson(e))
            .toList();
      });
    } catch (e) {
       return [];
    }
  }

  @override
  Future<void> update(Division division) async {
    try {
      await _dio.put('/organizations/division/${division.id}', data: division.toJson());
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar divisão.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/division/$id');
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar divisão.');
    }
  }
}
