import 'package:Better_UT_Menu/menu_info_dialog.dart';
import 'package:Better_UT_Menu/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// This is the page that display the menu items

const double FLAG_SIZE = 16;

class MenuPage extends StatelessWidget {
  final Meal meal;

  MenuPage(this.meal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: _getColumns(context),
          ),
        ),
      ),
    );
  }

  Widget _getColumns(BuildContext context) {
    List<Widget> firstColumnChildren = [];
    for (Line line in meal.lines) {
      List<DataRow> rows = [];
      for (MenuItem menuItem in line.items) {
        DataRow row = DataRow(

          cells: _getTableRow(menuItem, context)
        );
        rows.add(row);
      }
      firstColumnChildren.add(
        Container(
          width: 500,
          child: Card(
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
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Tags')),
                    DataColumn(label: Text('Cal'), numeric: true),
                    DataColumn(label: Text('')),
                  ],
                  rows: rows,
                ),
              ],
            ),
          ),
        )
      );        
    }
    return Column(
      children: firstColumnChildren,
    );
    // Row(
    //   children: [
    //     Column(
    //       children: [

    //       ],
    //     ),
    //     Column(
    //       children: [
            
    //       ],
    //     )
    //   ],
    // );
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
      DataCell(Row(children: _getTagWidets(menuItem))),
      DataCell(Text(menuItem.calories.round().toString())),
      DataCell(IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => MenuItemDialog(menuItem),
          );
        },
      )),
    ];
  }
}