import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class QuickBreakpad {
  static const MethodChannel _channel = const MethodChannel('quick_breakpad');

  /// Set the minidump path.
  static Future<void> setDumpPath(String path) async {
    // only works on Windows now.
    if (!Platform.isWindows) {
      return;
    }

    final type = await FileSystemEntity.type(path);
    if (type == FileSystemEntityType.notFound) {
      await Directory(path).create(recursive: true);
    } else if (type != FileSystemEntityType.directory) {
      assert(false, '$path is not a directory.');
      return;
    }
    await _channel.invokeMethod('setDumpPath', path);
  }
}
