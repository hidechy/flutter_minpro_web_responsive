// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class PageColor {
  static const sideMenuBGColor = Color(0xFF1B1B1B);
  static const taskListBGColor = Color(0xFF212121);
  static const detailBGColor = Color(0xFF424242);
}

class BreakPointWidth {
  static const double smallToMid = 600;
  static const double midToLarge = 1240;
}

enum ScreenSize { SMALL, MID, LARGE }

class DialogSize {
  static const double addTaskDialogWidth = 500;
  static const double addTaskDialogHeight = 500;
}
