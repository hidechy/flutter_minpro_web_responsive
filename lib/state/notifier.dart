import 'package:flutter/material.dart';

import '../util/styles.dart';

import 'repository.dart';

class Notifier extends ChangeNotifier {
  Notifier({required this.repository});

  final Repository repository;

  ScreenSize screenSize = ScreenSize.SMALL;
}
