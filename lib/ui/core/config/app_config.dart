/// Configuração centralizada da aplicação.
///
/// Valores podem ser sobrescritos via `--dart-define` no build:
/// ```
/// flutter run --dart-define=API_BASE_URL=https://api.production.com
/// flutter run --dart-define=ENVIRONMENT=production
/// ```
class AppConfig {
  AppConfig._();

  /// URL base da API.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8081',
  );

  /// Ambiente atual (development, staging, production).
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// Verifica se está em modo de desenvolvimento.
  static bool get isDevelopment => environment == 'development';

  /// Verifica se está em modo de produção.
  static bool get isProduction => environment == 'production';
}
