import 'package:dio/dio.dart';
import '../../domain/models/play.dart';
import '../../ui/core/exceptions/repository_exception.dart';

abstract class PlayService {
  Future<Play> register(Play play);
  Future<List<Play>> getPlaysByGameId(String gameId);
}

class PlayServiceImpl implements PlayService {
  final Dio _dio;

  PlayServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Play> register(Play play) async {
    try {
      return await _dio
          .post('/games/${play.gameId}/plays', data: play.toJson())
          .then((response) {
            return Play.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar jogada no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar a jogada. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Play>> getPlaysByGameId(String gameId) async {
    try {
      return await _dio.get('/games/$gameId/plays').then((response) {
        return (response.data as List).map((e) => Play.fromJson(e)).toList();
      });
    } catch (e) {
      return [];
    }
  }
}
