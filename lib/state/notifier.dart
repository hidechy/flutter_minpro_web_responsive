import 'package:flutter/material.dart';

import '../data/task.dart';
import '../util/styles.dart';

import 'repository.dart';

class Notifier extends ChangeNotifier {
  Notifier({required this.repository});

  final Repository repository;

  ScreenSize screenSize = ScreenSize.SMALL;

  List<Task> selectedTaskList = [];

  bool isSorted = false;

  bool isFinishedTaskIncluded = false;

  ///
  void addNewTask({
    required String title,
    required DateTime limitDateTime,
    required bool isImportant,
    required String detail,
  }) {
    repository.addNewTask(title: title, limitDateTime: limitDateTime, isImportant: isImportant, detail: detail);

    notifyListeners();
  }

  ///
  void getTaskList() {
    selectedTaskList = repository.getTaskList(isSorted: isSorted, isFinishedTaskIncluded: isFinishedTaskIncluded);

    notifyListeners();
  }
}
