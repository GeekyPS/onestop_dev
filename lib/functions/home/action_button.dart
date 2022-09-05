import 'package:flutter/material.dart';
import 'package:onestop_dev/functions/timetable/show_dialog.dart';
import 'package:onestop_dev/globals/my_colors.dart';

Widget homeActionButton(BuildContext context, int index) {
  return (index == 3)
      ? FloatingActionButton(
          backgroundColor: lBlue2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            showMyDialog(context);
          },
          child: const Icon(
            Icons.add,
            color: kBlack,
          ),
        )
      : const SizedBox();
}
