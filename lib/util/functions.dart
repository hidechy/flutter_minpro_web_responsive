import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/notifier.dart';
import 'constants.dart';
import 'styles.dart';

///
String convertDateTimeToString({required DateTime dateTime}) {
  return DateFormat.yMd('ja').format(dateTime);
}

///
void showSnackBar({
  required BuildContext context,
  required String contentText,
  required String flag,
  VoidCallback? onUndone,
}) {
  final notifier = context.read<Notifier>();

  if (notifier.screenSize == ScreenSize.SMALL) {
    final snackBar = SnackBar(
      content: Text(contentText),
      action: (flag == 'TaskListPage' || onUndone != null || flag == 'DetailPage_deleteTask')
          ? SnackBarAction(label: StringR.undo, onPressed: onUndone!)
          : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(contentText),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      if (flag == 'AddTaskPage') {
                        Navigator.pop(context);
                      }
                    },
                    child: AutoSizeText(StringR.close),
                  ),
                  if (flag == 'TaskListPage' || onUndone != null || flag == 'DetailPage_deleteTask')
                    TextButton(
                      onPressed: () {
                        onUndone!();

                        Navigator.pop(context);
                      },
                      child: AutoSizeText(StringR.undo),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
