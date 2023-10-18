// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../data/task.dart';
import '../../util/constants.dart';
import '../../util/functions.dart';
import '../../util/styles.dart';

class TaskContentPart extends StatefulWidget {
  const TaskContentPart({super.key, this.selectedTask, required this.isEditMode});

  final Task? selectedTask;
  final bool isEditMode;

  ///
  @override
  State<TaskContentPart> createState() => TaskContentPartState();
}

class TaskContentPartState extends State<TaskContentPart> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();

  bool isImportant = false;

  DateTime limitDateTime = DateTime.now();

  final formKey = GlobalKey<FormState>();

  Task? taskForEdit;

  ///
  @override
  void initState() {
    if (widget.isEditMode && widget.selectedTask != null) {
      taskForEdit = widget.selectedTask;

      setDetailData();
    }

    super.initState();
  }

  ///
  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();

    super.dispose();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  autofocus: true,
                  style: TextStyles.newTaskTitleTextStyle,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.title),
                    hintText: StringR.title,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty) ? StringR.pleaseEnterTitle : null,
                  autovalidateMode: AutovalidateMode.always,
                ),
                CustomSpacer.height8,
                Row(
                  children: [
                    CustomSpacer.width24,
                    Checkbox(
                      value: isImportant,
                      onChanged: (value) => setState(() => isImportant = value!),
                    ),
                    Text(StringR.important, style: TextStyles.newTaskItemTextStyle),
                  ],
                ),
                CustomSpacer.height8,
                Row(
                  children: [
                    CustomSpacer.width24,
                    IconButton(
                      onPressed: _setLimitDate,
                      icon: const Icon(Icons.calendar_today),
                    ),
                    Text(convertDateTimeToString(dateTime: limitDateTime), style: TextStyles.newTaskItemTextStyle),
                    CustomSpacer.width24,
                    (DateTime.now().compareTo(limitDateTime) > 0)
                        ? Chip(
                            label: Text(StringR.timeOver),
                            backgroundColor: Colors.redAccent,
                          )
                        : Container(),
                  ],
                ),
                CustomSpacer.height8,
                TextField(
                  controller: detailController,
                  maxLines: 10,
                  style: TextStyles.newTaskDetailTextStyle,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.description),
                    hintText: StringR.detail,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _setLimitDate() async {
    limitDateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 10)),
          lastDate: DateTime.now().add(const Duration(days: 10)),
        ) ??
        DateTime.now();

    setState(() {});
  }

  ///
  void setDetailData() {
    titleController.text = taskForEdit!.title;
    detailController.text = taskForEdit!.detail;
    isImportant = taskForEdit!.isImportant;
    limitDateTime = taskForEdit!.limitDateTime;
  }
}
