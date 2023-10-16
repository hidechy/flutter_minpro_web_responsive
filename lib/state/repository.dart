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
}
