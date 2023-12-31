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

  Task? currentTask;

  Task? taskBeforeChange;

  ///
  void addNewTask({
    required String title,
    required DateTime limitDateTime,
    required bool isImportant,
    required String detail,
  }) {
    repository.addNewTask(title: title, limitDateTime: limitDateTime, isImportant: isImportant, detail: detail);

    //修正もれな気がする
    getTaskList();

//    notifyListeners();
  }

  ///
  void getTaskList() {
    selectedTaskList = repository.getTaskList(isSorted: isSorted, isFinishedTaskIncluded: isFinishedTaskIncluded);

    notifyListeners();
  }

  ///
  void sort({required bool isSort}) {
    isSorted = isSort;

    getTaskList();
  }

  ///
  // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
  void finishTask({required Task selectedTask, required isFinished}) {
    taskBeforeChange = selectedTask;

    repository.finishTask(selectedTask: selectedTask, isFinished: isFinished);

    getTaskList();
  }

  ///
  void undo() {
    currentTask = taskBeforeChange;

    repository.undo();

    getTaskList();
  }

  ///
  void changeFinishStatus({required bool isIncluded}) {
    isFinishedTaskIncluded = isIncluded;

    getTaskList();
  }

  ///
  void deleteTask({required Task selectedTask}) {
    taskBeforeChange = selectedTask;

    repository.deleteTask(selectedTask: selectedTask);

    getTaskList();
  }

  ///
  void setCurrentTask(Task? selectedTask) {
    currentTask = selectedTask;

    notifyListeners();
  }

  ///
  void updateTask({required Task task}) {
    repository.updateTaskList(updateTask: task);

    getTaskList();
  }
}
