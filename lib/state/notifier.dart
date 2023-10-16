import 'package:flutter/material.dart';

import '../util/styles.dart';

import 'repository.dart';

class Notifier extends ChangeNotifier {
  Notifier({required this.repository});

  final Repository repository;

  ScreenSize screenSize = ScreenSize.SMALL;

  ///
  void addNewTask({
    required String title,
    required DateTime limitDateTime,
    required bool isImportant,
    required String detail,
  }) {
    repository.addNewTask(title: title, limitDateTime: limitDateTime, isImportant: isImportant, detail: detail);
  }
}
