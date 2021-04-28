import 'dart:io';

import 'package:Better_UT_Menu/models.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class MenuItemDialog extends StatefulWidget {
  final MenuItem menuItem;

  MenuItemDialog(this.menuItem);

  @override
  _MenuItemDialogState createState() => _MenuItemDialogState();
}

class _MenuItemDialogState extends State<MenuItemDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Table(
            children: [
              ['Calories: ', widget.menuItem.calories.toString() + 'kcal'],
              ['Carbs: ', widget.menuItem.carbs.toString() + 'g'],
              ['Fat: ', widget.menuItem.fat.toString() + 'g'],
              ['Sugars: ', widget.menuItem.sugars.toString() + 'g'],
              ['Protein: ', widget.menuItem.protein.toString() + 'g'],
            ].map((rowData) => TableRow(
              children: [
                Text(rowData[0]),
                Text(rowData[1])
              ]
            )).toList(),
          ),
          Divider(),
          ...widget.menuItem.tags.map((tag) => Text(tag)).toList(),
          Divider(),
          // EasyWebView(
          //   src: widget.menuItem.factsLink,
          //   width: 500,
          //   height: 500,
          //   isHtml: false,
          //   convertToWidgets: false,
          //   onLoaded: () {
          //     print(widget.menuItem.factsLink);
          //   },
          // ),
          Link(
            uri: Uri.parse(widget.menuItem.factsLink),
            target: LinkTarget.blank, 
            builder: (context, followLink) => TextButton(
              onPressed: followLink,
              child: Text('View All Facts')
            )
          )
        ],
      ),
    );
  }
}