import 'package:dio/dio.dart';

import '../../domain/models/league.dart';
import '../../domain/models/league_registration_model.dart';
import '../../ui/core/exceptions/repository_exception.dart';
import '../../ui/core/utils/app_logger.dart';

abstract class LeagueService {
  Future<League> register(LeagueRegistrationModel league);
}

class LeagueServiceImpl implements LeagueService {
  final Dio _dio;

  LeagueServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<League> register(LeagueRegistrationModel league) async {
    try {
      final response = await _dio.post(
        '/organizations/league',
        data: league.toJson(),
      );
      return League.fromJson(response.data);
    } on DioException catch (e, s) {
      AppLogger.error(
        'Erro ao registrar liga no serviço',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(
        message: 'Erro ao registrar a liga. Por favor, tente novamente.',
      );
    } catch (e, s) {
      AppLogger.error(
        'Erro inesperado no serviço de liga',
        error: e,
        stackTrace: s,
      );
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }
}
