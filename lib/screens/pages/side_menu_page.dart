// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';

class SideMenuPage extends StatelessWidget {
  SideMenuPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: PageColor.sideMenuBGColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const FlutterLogo(size: 100),
                  Text(StringR.appTitle),
                ],
              ),
            ),
            ListTile(
              title: Text(StringR.addNewTask),
              onTap: () {
                final notifier = context.read<Notifier>();

                if (notifier.screenSize != ScreenSize.LARGE) {
                  Navigator.pop(context);
                }

                _addNewTask();
              },
            ),
            SwitchListTile(
              value: false,
              onChanged: null,
              title: Text(StringR.isFinishedTaskIncluded),
            )
          ],
        ),
      ),
    );
  }

  ///
  void _addNewTask() {}
}
