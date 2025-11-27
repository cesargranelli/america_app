import '../../domain/models/play.dart';
import '../services/play_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class PlayRepository {
  Future<Play> registerPlay(Play play);
  Future<List<Play>> getPlaysByGameId(String gameId);
}

class PlayRepositoryImpl implements PlayRepository {
  final PlayService _playService;

  PlayRepositoryImpl({required PlayService playService})
      : _playService = playService;

  @override
  Future<Play> registerPlay(Play play) async {
    try {
      return await _playService.register(play);
    } on RepositoryException {
      rethrow;
    } catch (e) {
      throw RepositoryException(
        message: 'Erro desconhecido ao registrar a jogada.',
      );
    }
  }

  @override
  Future<List<Play>> getPlaysByGameId(String gameId) async {
    try {
      return await _playService.getPlaysByGameId(gameId);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar jogadas.');
    }
  }
}
