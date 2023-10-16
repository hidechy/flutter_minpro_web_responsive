// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Consumer<Notifier>(
      builder: (context, notifier, child) {
        final screenSize = notifier.screenSize;

        return Scaffold(
          backgroundColor: PageColor.taskListBGColor,
          appBar: AppBar(
            title: Text(StringR.taskList),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: _sort,
                icon: const Icon(Icons.sort),
              ),
            ],
          ),
          body: const SafeArea(
            child: Column(
              children: [
                Text('TaskListPage'),
              ],
            ),
          ),
          floatingActionButton: (screenSize == ScreenSize.LARGE)
              ? null
              : FloatingActionButton(
                  onPressed: _addNewTask,
                  child: const Icon(Icons.add),
                ),
        );
      },
    );
  }

  ///
  void _sort() {}

  ///
  void _addNewTask() {}
}
