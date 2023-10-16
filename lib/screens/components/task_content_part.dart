import 'package:flutter/material.dart';

class TaskContentPart extends StatelessWidget {
  const TaskContentPart({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.yellowAccent.withOpacity(0.2)),
        ),
      ),
    );
  }
}
