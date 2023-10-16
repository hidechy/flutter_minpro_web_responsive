// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';
import '../components/show_add_new_task_dialog.dart';
import '../components/task_list_card.dart';
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
              itemBuilder: (context, index) => TaskListCard(task: selectedTaskList[index]),
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
  void _sort({required bool isSort}) => _context.read<Notifier>().sort(isSort: isSort);

  ///
  void _addNewTask() {
    showAddNewTaskDialog(_context);
  }
}
