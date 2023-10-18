// ignore: constant_identifier_names
// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:flutter/foundation.dart';

// ignore: constant_identifier_names
enum TaskListTileMenu { EDIT, DELETE }

class DeviceInfo {
  static bool get isDesktop => !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  static bool get isWebOrDesktop => kIsWeb || isDesktop;
}
