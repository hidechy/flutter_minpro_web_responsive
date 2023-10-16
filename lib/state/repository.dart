import '../data/task.dart';

class Repository {
  ///
  void addNewTask({
    required String title,
    required DateTime limitDateTime,
    required bool isImportant,
    required String detail,
  }) {
    final nextId = getNextId();

    final newTask = Task(
      id: nextId,
      title: title,
      detail: detail,
      limitDateTime: limitDateTime,
      isImportant: isImportant,
      isFinished: false,
    );

    baseTaskList.add(newTask);
  }

  ///
  int getNextId() {
    final maxId = baseTaskList.reduce((todoListItemCurrent, todoListItemNext) {
      return (todoListItemCurrent.id > todoListItemNext.id) ? todoListItemCurrent : todoListItemNext;
    }).id;

    return maxId + 1;
  }

  ///
  List<Task> getTaskList({required bool isSorted, required bool isFinishedTaskIncluded}) {
    var taskList = <Task>[];

    taskList = getBaseTaskList(isFinishedTaskIncluded: isFinishedTaskIncluded);

    if (isSorted) {
      return sortByImportant(taskList: taskList);
    }

    return taskList;
  }

  ///
  List<Task> getBaseTaskList({required bool isFinishedTaskIncluded}) {
    baseTaskList.sort((a, b) {
      return a.limitDateTime.compareTo(b.limitDateTime);
    });

    return baseTaskList;
  }

  ///
  List<Task> sortByImportant({required List<Task> taskList}) {
    taskList.sort((a, b) {
//      return (a.isImportant) ? -1 : 1;

      final isImportantA = a.isImportant;
      final isImportantB = b.isImportant;

      final limitDateTimeCompare = a.limitDateTime.compareTo(b.limitDateTime);

      if (isImportantA == true && (isImportantB == false || limitDateTimeCompare < 0)) {
        return -1;
      } else if (isImportantB == false && limitDateTimeCompare < 0) {
        return -1;
      } else {
        return 1;
      }
    });

    return taskList;
  }
}
