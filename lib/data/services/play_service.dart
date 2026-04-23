import 'package:dio/dio.dart';
import '../../domain/models/play.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

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
      final response = await _dio.post(
        '/games/${play.gameId}/plays',
        data: play.toJson(),
      );
      return Play.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar jogada no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar a jogada. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de jogada',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<List<Play>> getPlaysByGameId(String gameId) async {
    try {
      final response = await _dio.get('/games/$gameId/plays');
      return (response.data as List).map((e) => Play.fromJson(e)).toList();
    } catch (e, s) {
      AppLogger.error('Erro ao buscar jogadas', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar jogadas.');
    }
  }
}
