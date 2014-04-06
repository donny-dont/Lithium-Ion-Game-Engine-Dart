// Copyright (c) 2013-2014, the Lithium-Ion Engine Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

part of lithium_foundation;

void debug(String message, String name) {
  var logger = new Logger(name);

  logger.info(message);
}

void warn(String message, String name) {
  var logger = new Logger(name);

  logger.warning(message);
}

void _logHandler(LogRecord record) {
  print('[${record.level}] ${record.loggerName}: ${record.message}');
}

/// Enables logging
void enableLogging() {
  hierarchicalLoggingEnabled = true;

  var root = Logger.root;

  root.level = Level.FINEST;
  root.onRecord.listen(_logHandler);
}
