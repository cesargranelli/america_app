/// Uma classe de exceção personalizada para erros que ocorrem na camada de repositório ou serviço.
///
/// Implementar a interface [Exception] permite que ela seja tratada em blocos `catch`.
class RepositoryException implements Exception {
  /// A mensagem de erro destinada ao usuário final ou para logs.
  final String message;

  /// Construtor que exige uma mensagem de erro.
  RepositoryException({required this.message});

  /// Sobrescreve o método `toString()` para fornecer uma representação legível da exceção.
  ///
  /// Isso é útil para depuração e logging, pois ao fazer `print(exception)`,
  /// esta string será exibida.
  @override
  String toString() => 'RepositoryException: $message';
}
