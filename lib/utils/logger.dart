import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log('DEBUG', message, error, stackTrace);
  }

  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    _log('INFO', message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log('WARNING', message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log('ERROR', message, error, stackTrace);
  }
  static void _log(
    String level,
    String message,
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final sanitizedMessage = _sanitizeSensitiveData(message);

      final logMessage = StringBuffer()
        ..write('[$timestamp] [$level] $sanitizedMessage');

      if (error != null) {
        logMessage.write('\n  Error: $error');
      }

      if (stackTrace != null) {
        logMessage.write('\n  StackTrace:\n$stackTrace');
      }

      debugPrint(logMessage.toString());
    }
  }

  static String _sanitizeSensitiveData(String input) {
    return input
        .replaceAll(RegExp(r'(password|token|bearer|secret)=[^&\s]+', caseSensitive: false), r'$1=[REDACTED]')
        .replaceAll(RegExp(r'("password"|"token"|"authorization")\s*:\s*"[^"]+"', caseSensitive: false), r'$1: "[REDACTED]"');
  }
}