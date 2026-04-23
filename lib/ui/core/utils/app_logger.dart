import 'package:logger/logger.dart';

/// Logger centralizado para toda a aplicação.
///
/// Uso:
/// ```dart
/// AppLogger.debug('Mensagem de debug');
/// AppLogger.info('Informação');
/// AppLogger.warning('Aviso');
/// AppLogger.error('Erro', error: exception, stackTrace: stackTrace);
/// ```
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  AppLogger._();

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);

  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
