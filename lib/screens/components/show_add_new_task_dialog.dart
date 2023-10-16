import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/styles.dart';
import '../add_task_screen.dart';
import '../pages/add_task_page.dart';

void showAddNewTaskDialog(BuildContext context) {
  final notifier = context.read<Notifier>();

  switch (notifier.screenSize) {
    case ScreenSize.SMALL:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskScreen()));
      break;

    case ScreenSize.MID:
    case ScreenSize.LARGE:
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: SizedBox(
            width: DialogSize.addTaskDialogWidth,
            height: DialogSize.addTaskDialogHeight,
            child: AddTaskPage(),
          ),
        ),
      );
      break;
  }
}
