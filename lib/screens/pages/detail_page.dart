import 'package:flutter/material.dart';

import '../../util/styles.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: PageColor.detailBGColor,
      body: SafeArea(
        child: Column(
          children: [
            Text('DetailPage'),
          ],
        ),
      ),
    );
  }
}
