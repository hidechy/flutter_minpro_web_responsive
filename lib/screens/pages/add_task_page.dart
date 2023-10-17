// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';
import '../components/task_content_part.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  final taskContentKey = GlobalKey<TaskContentPartState>();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text(StringR.addNewTask),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: _onDoneAddNewTask,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: TaskContentPart(key: taskContentKey, isEditMode: false),
    );
  }

  ///
  void _onDoneAddNewTask() {
    final taskContentState = taskContentKey.currentState;
    if (taskContentState == null) {
      return;
    }

    if (taskContentState.formKey.currentState!.validate()) {
      _context.read<Notifier>().addNewTask(
            title: taskContentState.titleController.text,
            limitDateTime: taskContentState.limitDateTime,
            isImportant: taskContentState.isImportant,
            detail: taskContentState.detailController.text,
          );

      showSnackBar(
        context: _context,
        contentText: StringR.addTaskCompleted,
        flag: 'AddTaskPage',
      );

      if (_context.read<Notifier>().screenSize == ScreenSize.SMALL) {
        Navigator.pop(_context);
      }
    }
  }
}
