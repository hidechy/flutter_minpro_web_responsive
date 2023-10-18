// ignore_for_file: strict_raw_type

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';
import '../../util/const.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
    required this.task,
    required this.onFinishChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final Task task;

  final ValueChanged onFinishChanged;

  final VoidCallback onDelete;

  final VoidCallback onEdit;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      color: (DateTime.now().compareTo(task.limitDateTime) > 0) ? Colors.redAccent : CustomColors.detailBGColor,
      child: ListTile(
        leading: Radio(
          value: true,
          groupValue: task.isFinished,
          onChanged: onFinishChanged,
        ),
        onLongPress: onDelete,
        onTap: onEdit,
        title: Row(
          children: [
            if (task.isImportant) ...[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  StringR.important,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              CustomSpacer.width10,
            ],
            Expanded(
              child: Text(
                task.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: AutoSizeText(convertDateTimeToString(dateTime: task.limitDateTime)),
        trailing: PopupMenuButton(
          tooltip: StringR.showMenu,
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) {
            return [
              PopupMenuItem<TaskListTileMenu>(child: Text(StringR.edit), value: TaskListTileMenu.EDIT),
              PopupMenuItem<TaskListTileMenu>(child: Text(StringR.delete), value: TaskListTileMenu.DELETE),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case TaskListTileMenu.EDIT:
                onEdit();
                break;

              case TaskListTileMenu.DELETE:
                onDelete();
                break;
            }
          },
        ),
      ),
    );
  }
}
