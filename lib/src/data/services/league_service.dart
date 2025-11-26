import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../data/models/league_registration_model.dart';

// Interface para facilitar a injeção de dependência e testes
abstract class LeagueService {
  Future<void> register(LeagueRegistrationModel league);
}

class LeagueServiceImpl implements LeagueService {
  final Dio _dio;

  LeagueServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<void> register(LeagueRegistrationModel league) async {
    try {
      // O endpoint é um exemplo, ajuste para a sua API real
      await _dio.post(
        '/organizations/league', // Exemplo de endpoint
        data: league.toJson(),
      );
    } on DioException catch (e, s) {
      // DioException é mais específico para erros de rede com o Dio
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
