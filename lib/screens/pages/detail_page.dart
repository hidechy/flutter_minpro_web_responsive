// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_minpro_web_responsive/state/notifier.dart';
import 'package:tuple/tuple.dart';

import '../../data/task.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

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
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                  ]
                : null,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Text(selectedTask?.title ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  void _clearCurrentTask({Task? selectedTask}) {
    _context.read<Notifier>().setCurrentTask(null);
  }
}
