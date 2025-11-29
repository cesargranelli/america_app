import 'package:america_app/domain/models/league.dart';
import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../models/league_registration_model.dart';

abstract class LeagueService {
  Future<League> register(LeagueRegistrationModel league);
}

class LeagueServiceImpl implements LeagueService {
  final Dio _dio;

  LeagueServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<League> register(LeagueRegistrationModel league) async {
    try {
      return await _dio
          .post('/organizations/league', data: league.toJson())
          .then((response) {
            return League.fromJson(response.data);
          }, onError: (error) {});
    } on DioException catch (e, s) {
      print('Erro ao registrar liga no serviço: $e, stack: $s');
      throw RepositoryException(
        message: 'Erro ao registrar a liga. Por favor, tente novamente.',
      );
    } catch (e, s) {
      print('Erro inesperado no serviço: $e, stack: $s');
      throw RepositoryException(message: 'Ocorreu um erro inesperado.');
    }
  }
}
