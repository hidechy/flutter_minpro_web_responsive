// ignore_for_file: strict_raw_type

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/task.dart';
import '../../util/const.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';

class TaskListCard extends StatefulWidget {
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

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  bool isPopupMenuDisplay = false;

  ///
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => isPopupMenuDisplay = true),
      onExit: (event) => setState(() => isPopupMenuDisplay = false),
      child: Card(
        color:
            (DateTime.now().compareTo(widget.task.limitDateTime) > 0) ? Colors.redAccent : CustomColors.detailBGColor,
        child: ListTile(
          leading: Radio(
            value: true,
            groupValue: widget.task.isFinished,
            onChanged: widget.onFinishChanged,
          ),
          onLongPress: widget.onDelete,
          onTap: widget.onEdit,
          title: Row(
            children: [
              if (widget.task.isImportant) ...[
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
                  widget.task.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          subtitle: AutoSizeText(convertDateTimeToString(dateTime: widget.task.limitDateTime)),
          trailing: PopupMenuButton(
            tooltip: StringR.showMenu,
            icon: isPopupMenuDisplay ? const Icon(Icons.more_vert) : Container(),
            itemBuilder: (context) {
              return [
                PopupMenuItem<TaskListTileMenu>(value: TaskListTileMenu.EDIT, child: Text(StringR.edit)),
                PopupMenuItem<TaskListTileMenu>(value: TaskListTileMenu.DELETE, child: Text(StringR.delete)),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case TaskListTileMenu.EDIT:
                  widget.onEdit();
                  break;

                case TaskListTileMenu.DELETE:
                  widget.onDelete();
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
