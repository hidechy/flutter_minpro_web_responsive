import 'package:flutter/material.dart';

import '../../util/styles.dart';

class SideMenuPage extends StatelessWidget {
  const SideMenuPage({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PageColor.sideMenuBGColor,
      body: SafeArea(
        child: Column(
          children: [
            Text('SideMenuPage'),
          ],
        ),
      ),
    );
  }
}
