import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({super.key, required this.task});

  final Task task;

  ///
  @override
  Widget build(BuildContext context) {
    return Card(
      color: (DateTime.now().compareTo(task.limitDateTime) > 0) ? Colors.redAccent : CustomColors.detailBGColor,
      child: ListTile(
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
            Text(task.title),
          ],
        ),
        subtitle: AutoSizeText(convertDateTimeToString(dateTime: task.limitDateTime)),
      ),
    );
  }
}
