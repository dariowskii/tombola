import 'dart:developer' as developer;

const kTerminalGreenColor = '\x1B[32m';
const kTerminalRedColor = '\x1B[31m';
const kTerminalYellowColor = '\x1B[33m';
const kTerminalBlueColor = '\x1B[34m';
const kTerminalMagentaColor = '\x1B[35m';
const kTerminalCyanColor = '\x1B[36m';
const kTerminalWhiteColor = '\x1B[37m';
const kTerminalBlackColor = '\x1B[30m';
const kTerminalBold = '\x1B[1m';
const kTerminalUnderline = '\x1B[4m';
const kTerminalInverse = '\x1B[7m';
const kTerminalReset = '\x1B[0m';

enum LogLevel {
  trace,
  debug,
  info,
  warning,
  error,
}

class Logger {
  final String _name;
  final LogLevel _logLevel;

  const Logger({
    required String name,
    LogLevel logLevel = LogLevel.trace,
  })  : _name = name,
        _logLevel = logLevel;

  static const Logger _instance = Logger(name: 'log');
  static Logger get general => _instance;

  String _getColor(LogLevel level) {
    return switch (level) {
      LogLevel.trace => kTerminalMagentaColor,
      LogLevel.debug => kTerminalCyanColor,
      LogLevel.info => kTerminalGreenColor,
      LogLevel.warning => kTerminalYellowColor,
      LogLevel.error => kTerminalRedColor,
    };
  }

  void log({
    required LogLevel level,
    required Object message,
  }) {
    if (level.index < _logLevel.index) {
      return;
    }

    final color = _getColor(level);
    final logLevel = level.name.toUpperCase();

    developer.log(
      '$color[$logLevel]: $message$kTerminalReset',
      name: _name,
    );
  }

  void trace(Object message) {
    log(level: LogLevel.trace, message: message);
  }

  void debug(Object message) {
    log(level: LogLevel.debug, message: message);
  }

  void info(Object message) {
    log(level: LogLevel.info, message: message);
  }

  void warning(Object message) {
    log(level: LogLevel.warning, message: message);
  }

  void error(Object message) {
    log(level: LogLevel.error, message: message);
  }
}
