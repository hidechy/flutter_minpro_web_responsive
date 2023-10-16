import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/notifier.dart';
import '../util/styles.dart';
import 'pages/detail_page.dart';
import 'pages/side_menu_page.dart';
import 'pages/task_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    final notifier = context.read<Notifier>();

    return LayoutBuilder(
      builder: (contest, constraints) {
        if (constraints.maxWidth >= BreakPointWidth.midToLarge) {
          notifier.screenSize = ScreenSize.LARGE;

          return const Row(
            children: [
              Expanded(flex: 3, child: SideMenuPage()),
              Expanded(flex: 4, child: TaskListPage()),
              Expanded(flex: 6, child: DetailPage()),
            ],
          );
        }

        //======================

        else if (constraints.maxWidth >= BreakPointWidth.smallToMid) {
          notifier.screenSize = ScreenSize.MID;

          return const Row(
            children: [
              Expanded(child: TaskListPage()),
              Expanded(flex: 2, child: DetailPage()),
            ],
          );
        }

        //======================

        else {
          notifier.screenSize = ScreenSize.SMALL;

          return const TaskListPage();
        }
      },
    );
  }
}
