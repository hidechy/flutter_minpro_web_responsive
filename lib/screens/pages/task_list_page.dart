import 'package:flutter/material.dart';

import '../../util/styles.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PageColor.taskListBGColor,
      body: SafeArea(
        child: Column(
          children: [
            Text('TaskListPage'),
          ],
        ),
      ),
    );
  }
}
