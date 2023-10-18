// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../data/task.dart';
import '../../state/notifier.dart';
import '../../util/const.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';
import '../components/show_add_new_task_dialog.dart';
import '../components/task_list_card.dart';
import '../detail_screen.dart';
import 'side_menu_page.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    // Futureを使用しないと「setState or markNeedBuild...」みたいなエラーが出る
    Future(() => context.read<Notifier>().getTaskList());

    return Consumer<Notifier>(
      builder: (context, notifier, child) {
        final screenSize = notifier.screenSize;

        final selectedTaskList = notifier.selectedTaskList;

        final isSorted = notifier.isSorted;

        return Scaffold(
          backgroundColor: CustomColors.taskListBGColor,
          appBar: AppBar(
            title: Text(StringR.taskList),
            centerTitle: true,
            actions: [
              isSorted
                  ? IconButton(
                      onPressed: () => _sort(isSort: false),
                      icon: const Icon(Icons.undo),
                    )
                  : IconButton(
                      onPressed: () => _sort(isSort: true),
                      icon: const Icon(Icons.sort),
                    ),
            ],
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: selectedTaskList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => (DeviceInfo.isWebOrDesktop)
                  ? _callTaskListCard(task: selectedTaskList[index])
                  : Slidable(
                      key: ValueKey<int>(selectedTaskList[index].id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.6,
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            _deleteTask(selectedTask: selectedTaskList[index]);
                          },
                        ),
                        children: [
                          SlidableAction(
                            onPressed: (context) => _showDetailTask(selectedTask: selectedTaskList[index]),
                            label: StringR.edit,
                            icon: Icons.edit,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.greenAccent.withOpacity(0.3),
                          ),
                          SlidableAction(
                            onPressed: (context) => _deleteTask(selectedTask: selectedTaskList[index]),
                            label: StringR.delete,
                            icon: Icons.delete,
                            backgroundColor: Colors.redAccent.withOpacity(0.3),
                          ),
                          SlidableAction(
                            onPressed: null,
                            label: StringR.close,
                            icon: Icons.close,
                          ),
                        ],
                      ),
                      child: _callTaskListCard(task: selectedTaskList[index]),
                    ),
            ),
          ),
          floatingActionButton: (screenSize == ScreenSize.LARGE)
              ? null
              : FloatingActionButton(
                  onPressed: _addNewTask,
                  child: const Icon(Icons.add),
                ),
          drawer: (screenSize != ScreenSize.LARGE)
              ? Drawer(
                  child: SideMenuPage(),
                )
              : null,
        );
      },
    );
  }

  ///
  Widget _callTaskListCard({required Task task}) {
    return TaskListCard(
      task: task,
      onFinishChanged: (value) => _finishTask(isFinished: value, selectedTask: task),
      onDelete: () => _deleteTask(selectedTask: task),
      onEdit: () => _showDetailTask(selectedTask: task),
    );
  }

  ///
  void _sort({required bool isSort}) => _context.read<Notifier>().sort(isSort: isSort);

  ///
  void _addNewTask() {
    showAddNewTaskDialog(_context);
  }

  ///
  // ignore: inference_failure_on_untyped_parameter
  void _finishTask({required isFinished, required Task selectedTask}) {
    if (isFinished == null) {
      return;
    }

    _context.read<Notifier>().finishTask(selectedTask: selectedTask, isFinished: isFinished);

    showSnackBar(
      context: _context,
      contentText: StringR.finishTaskCompleted,
      flag: 'TaskListPage',
      onUndone: () {
        _context.read<Notifier>().undo();
      },
    );

    _context.read<Notifier>().setCurrentTask(null);
  }

  ///
  void _deleteTask({required Task selectedTask}) {
    _context.read<Notifier>().deleteTask(selectedTask: selectedTask);

    showSnackBar(
      context: _context,
      contentText: StringR.deleteTaskCompleted,
      flag: 'TaskListPage',
      onUndone: () {
        _context.read<Notifier>().undo();
      },
    );

    _context.read<Notifier>().setCurrentTask(null);
  }

  ///
  void _showDetailTask({required Task selectedTask}) {
    _context.read<Notifier>().setCurrentTask(selectedTask);

    if (_context.read<Notifier>().screenSize == ScreenSize.SMALL) {
      Navigator.push(_context, MaterialPageRoute(builder: (context) => const DetailScreen()));
    }
  }
}
