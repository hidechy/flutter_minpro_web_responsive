// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/notifier.dart';
import '../../util/constants.dart';
import '../../util/styles.dart';
import '../components/show_add_new_task_dialog.dart';

class SideMenuPage extends StatelessWidget {
  SideMenuPage({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: CustomColors.sideMenuBGColor,
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
            ),
            AboutListTile(
              icon: const Icon(Icons.info_outline),
              applicationIcon: const FlutterLogo(),
              applicationName: StringR.appTitle,
              applicationLegalese: '\u{a9} 2023 hidechy',
              aboutBoxChildren: const [
                Text('いろんな情報'),
                Text('いろんな情報'),
              ],
            ),
            ListTile(
              title: Text(StringR.showLicense),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: const FlutterLogo(),
                  applicationName: StringR.appTitle,
                  applicationLegalese: '\u{a9} 2023 hidechy',
                  children: const [
                    Text('いろんな情報'),
                    Text('いろんな情報'),
                  ],
                );
              },
            ),
            ListTile(
              title: Text(StringR.showLicense),
              onTap: () {
                showLicensePage(
                  context: context,
                  applicationIcon: const FlutterLogo(),
                  applicationName: StringR.appTitle,
                  applicationLegalese: '\u{a9} 2023 hidechy',
                  applicationVersion: '1.0',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  void _addNewTask() {
    showAddNewTaskDialog(_context);
  }
}
