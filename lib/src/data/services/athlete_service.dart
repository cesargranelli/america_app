import 'package:dio/dio.dart';
import '../../domain/models/athlete.dart';
import '../../core/exceptions/repository_exception.dart';

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
      return await _dio
          .post('/organizations/athlete', data: athlete.toJson())
          .then((response) {
            return Athlete.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar atleta no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar o atleta. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Athlete>> getAll() async {
    try {
      return await _dio.get('/organizations/athlete').then((response) {
        return (response.data as List)
            .map((e) => Athlete.fromJson(e))
            .toList();
      });
    } catch (e) {
       return [];
    }
  }

  @override
  Future<void> update(Athlete athlete) async {
    try {
      await _dio.put('/organizations/athlete/${athlete.id}', data: athlete.toJson());
    } catch (e) {
      throw RepositoryException(message: 'Erro ao atualizar atleta.');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _dio.delete('/organizations/athlete/$id');
    } catch (e) {
      throw RepositoryException(message: 'Erro ao deletar atleta.');
    }
  }
}
