import 'package:Better_UT_Menu/legend_dialog.dart';
import 'package:Better_UT_Menu/menu_info_dialog.dart';
import 'package:Better_UT_Menu/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_web_view/easy_web_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// This is the page that display the menu items

const double FLAG_SIZE = 16;

class MenuPage extends StatefulWidget {
  final Location location;
  final String mealName;

  MenuPage(this.location, this.mealName);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> disabledTags = [];

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String dateString = '${date.month}-${date.day}-${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealName + ' at ' + widget.location.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              List<String> result = await showDialog(
                context: context,
                builder: (context) => LegendDialog(disabledTags)
              );
              if (result != null) {
                setState(() {
                  disabledTags = result;
                });
              }
            },
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('locations').doc(widget.location.id).collection('meals').doc(widget.mealName + '-' + dateString).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          Meal meal = Meal.fromJSON(snapshot.data.data());
          return Scrollbar(
            child: SingleChildScrollView(
              child: Center(
                child: _getColumns(context, meal)
              )
            )
          );
        }
      ),
    );
  }

  bool _itemVisible(MenuItem menuItem) {
    for (String tag in disabledTags) {
      if (menuItem.tags.contains(tag))
        return false;
    }
    return true;
  }

  Widget _getColumns(BuildContext context, Meal meal) {
    List<Widget> firstColumnChildren = [];
    for (Line line in meal.lines) {
      List<DataRow> rows = [];
      for (MenuItem menuItem in line.items) {
        if (_itemVisible(menuItem)) {
          DataRow row = DataRow(
            cells: _getTableRow(menuItem, context),
            onSelectChanged: (value) {
              showDialog(
                context: context,
                builder: (context) => MenuItemDialog(menuItem),
              );
            },
          );
          rows.add(row);
        }
      }
      firstColumnChildren.add(
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  line.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
              ),
              DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Tags')),
                  DataColumn(label: Text('Cal'), numeric: true),
                ],
                rows: rows,
              ),
            ],
          ),
        )
      );        
    }
    return Column(
      children: firstColumnChildren,
    );
  }

  List<Widget> _getTagWidets(MenuItem menuItem) {
    List<Widget> tagWidgets = [];
    for (String tag in menuItem.tags) {
      String fileName = 'assets/${tag.replaceAll(' ', '')}.png';
      tagWidgets.add(
        Tooltip(
          message: tag,
          child: Image.asset(fileName, width: FLAG_SIZE, height: FLAG_SIZE),
        )
      );
      tagWidgets.add(Container(width: 8));
    }
    return tagWidgets;
  }

  List<DataCell> _getTableRow(MenuItem menuItem, BuildContext context) {
    return [
      DataCell(Text(menuItem.name)),
      DataCell(
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: 150
          ),
          child: Wrap(children: _getTagWidets(menuItem), alignment: WrapAlignment.start))),
      DataCell(Text(menuItem.calories?.round()?.toString() ?? '?')),
    ];
  }
}