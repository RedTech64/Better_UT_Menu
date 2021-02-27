import 'package:Better_UT_Menu/models.dart';
import 'package:flutter/material.dart';

class MenuItemDialog extends StatelessWidget {
  final MenuItem menuItem;

  MenuItemDialog(this.menuItem);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}