// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../util/constants.dart';

import '../components/task_content_part.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

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
      body: const TaskContentPart(),
    );
  }

  ///
  void _onDoneAddNewTask() {}
}
