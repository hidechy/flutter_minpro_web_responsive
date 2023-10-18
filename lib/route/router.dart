// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../digression/custom_dialog_page.dart';
import '../screens/add_task_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/pages/add_task_page.dart';
import '../util/styles.dart';

class RouteNames {
  static String home = 'home';
  static String addTask = 'addTask';
  static String detail = 'detail';

  //
  static String addTaskDialog = 'addTaskDialog';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'addTask',
          name: RouteNames.addTask,
          builder: (context, state) => const AddTaskScreen(),
        ),
        GoRoute(
          path: 'detail',
          name: RouteNames.detail,
          builder: (context, state) => const DetailScreen(),
        ),

        //
        GoRoute(
          path: 'addTaskDialog',
          name: RouteNames.addTaskDialog,
          pageBuilder: (context, state) {
            return CustomDialogPage(
              builder: (context2) {
                return Dialog(
                  child: SizedBox(
                    width: DialogSize.addTaskDialogWidth,
                    height: DialogSize.addTaskDialogHeight,
                    child: AddTaskPage(),
                  ),
                );
              },
            );
          },
        ),
      ],
    ),
  ],
);
