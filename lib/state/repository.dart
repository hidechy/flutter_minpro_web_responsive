import '../data/task.dart';

class Repository {
  List<Task> baseTaskListBeforeChange = [];

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

//    return baseTaskList;

    if (isFinishedTaskIncluded) {
      return baseTaskList;
    } else {
      return baseTaskList.where((element) => element.isFinished == false).toList();
    }
  }

  ///
  List<Task> sortByImportant({required List<Task> taskList}) {
    /*
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
    */

    final subListImportant = taskList.where((element) => element.isImportant == true).toList();
    final subListNotImportant = taskList.where((element) => element.isImportant == false).toList();

    subListImportant.sort((a, b) {
      return a.limitDateTime.compareTo(b.limitDateTime);
    });

    subListNotImportant.sort((a, b) {
      return a.limitDateTime.compareTo(b.limitDateTime);
    });

    return [...subListImportant, ...subListNotImportant];
  }

  ///
  // ignore: inference_failure_on_untyped_parameter, type_annotate_public_apis
  void finishTask({required Task selectedTask, required isFinished}) {
    //
//    baseTaskListBeforeChange = baseTaskList;    //参照渡しのため、=では値は入らない
    baseTaskListBeforeChange = copyBaseTaskList();

    //

    final updateTask = selectedTask.copyWith(isFinished: isFinished);

    updateTaskList(updateTask: updateTask);
  }

  ///
  void updateTaskList({required Task updateTask}) {
    final index = searchIndex(selectedTask: updateTask);

    baseTaskList[index] = updateTask;
  }

  ///
  int searchIndex({required Task selectedTask}) {
    return baseTaskList.indexWhere((element) => element.id == selectedTask.id);
  }

  ///
  void undo() {
    baseTaskList = baseTaskListBeforeChange;
  }

  ///
  List<Task> copyBaseTaskList() {
    final returnList = <Task>[];

    baseTaskList.forEach(returnList.add);

    return returnList;
  }

  ///
  void deleteTask({required Task selectedTask}) {
    baseTaskListBeforeChange = copyBaseTaskList();

    final index = searchIndex(selectedTask: selectedTask);

    baseTaskList.removeAt(index);
  }
}
