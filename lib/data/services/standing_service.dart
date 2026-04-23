import 'package:dio/dio.dart';
import '../../domain/models/standing.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class StandingService {
  Future<List<Standing>> getStandings(String championshipId);
}

class StandingServiceImpl implements StandingService {
  // ignore: unused_field — will be used when mock is replaced with real API call
  final Dio _dio;

  StandingServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<Standing>> getStandings(String championshipId) async {
    try {
      // TODO: Substituir mock por chamada real quando o backend estiver pronto.
      // final response = await _dio.get('/championships/$championshipId/standings');
      // return (response.data as List).map((e) => Standing.fromJson(e)).toList();
      await Future.delayed(const Duration(seconds: 1));
      return [
        Standing(
          teamId: '1',
          teamName: 'Time A',
          wins: 10,
          losses: 2,
          points: 20,
        ),
        Standing(
          teamId: '2',
          teamName: 'Time B',
          wins: 9,
          losses: 3,
          points: 18,
        ),
        Standing(
          teamId: '3',
          teamName: 'Time C',
          wins: 8,
          losses: 4,
          points: 16,
        ),
        Standing(
          teamId: '4',
          teamName: 'Time D',
          wins: 5,
          losses: 7,
          points: 10,
        ),
      ];
    } catch (e, s) {
      AppLogger.error('Erro ao buscar classificação', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar classificação.');
    }
  }
}
