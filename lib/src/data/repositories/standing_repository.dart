import '../../domain/models/standing.dart';
import '../services/standing_service.dart';
import '../../core/exceptions/repository_exception.dart';

abstract class StandingRepository {
  Future<List<Standing>> getStandings(String championshipId);
}

class StandingRepositoryImpl implements StandingRepository {
  final StandingService _standingService;

  StandingRepositoryImpl({required StandingService standingService})
      : _standingService = standingService;

  @override
  Future<List<Standing>> getStandings(String championshipId) async {
    try {
      return await _standingService.getStandings(championshipId);
    } catch (e) {
      throw RepositoryException(message: 'Erro ao buscar classificação.');
    }
  }
}
