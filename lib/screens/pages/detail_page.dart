// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../data/task.dart';
import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';
import '../components/task_content_part.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final taskContentPartKey = GlobalKey<TaskContentPartState>();

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Selector<Notifier, Tuple2<Task?, ScreenSize>>(
      selector: (context, notifier) => Tuple2(notifier.currentTask, notifier.screenSize),
      builder: (context, data, child) {
        final selectedTask = data.item1;
        final screenSize = data.item2;

        if (selectedTask != null && screenSize != ScreenSize.SMALL) {
          _updateDetailInfo(selectedTask: selectedTask);
        }

        return Scaffold(
          backgroundColor: CustomColors.detailBGColor,
          appBar: AppBar(
            title: Text(StringR.taskDetail),
            centerTitle: true,
            leading: (selectedTask != null)
                ? IconButton(
                    onPressed: () {
                      _clearCurrentTask(selectedTask: selectedTask);

                      if (screenSize == ScreenSize.SMALL) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.close),
                  )
                : null,
            actions: (selectedTask != null)
                ? [
                    IconButton(
                      onPressed: () => _updateTask(selectedTask: selectedTask),
                      icon: const Icon(Icons.done),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ]
                : null,
          ),
          body: (selectedTask != null)
              ? SafeArea(
                  child: TaskContentPart(
                    key: taskContentPartKey,
                    selectedTask: selectedTask,
                    isEditMode: true,
                  ),
                )
              : null,
        );
      },
    );
  }

  ///
  void _clearCurrentTask({Task? selectedTask}) {
    _context.read<Notifier>().setCurrentTask(null);
  }

  ///
  void _updateDetailInfo({required Task selectedTask}) {
    final taskContentPartState = taskContentPartKey.currentState;

    if (taskContentPartState == null) {
      return;
    }

    taskContentPartState
      ..taskForEdit = selectedTask
      ..setDetailData();
  }

  ///
  void _updateTask({required Task selectedTask}) {
    final taskContentPartState = taskContentPartKey.currentState;

    if (taskContentPartState == null) {
      return;
    }

    if (taskContentPartState.formKey.currentState!.validate()) {
      final taskForUpdate = selectedTask.copyWith(
        title: taskContentPartState.titleController.text,
        detail: taskContentPartState.detailController.text,
        limitDateTime: taskContentPartState.limitDateTime,
        isImportant: taskContentPartState.isImportant,
      );

      _context.read<Notifier>().updateTask(task: taskForUpdate);
    }
  }
}
