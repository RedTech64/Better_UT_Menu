import 'package:Better_UT_Menu/models.dart';

import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final Meal meal;

  MenuPage(this.meal);

  @override
  Widget build(BuildContext context) {
    print(meal.lines);
    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: meal.lines.length,
        itemBuilder: (context, menuIndex) {
          Line line = meal.lines[menuIndex];
          return Card(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: line.items.length,
              itemBuilder: (context, itemIndex) => _getMenuItemRow(line.items[itemIndex]),
            ),
          );
        },
      ),
    );
  }

  Widget _getMenuItemRow(MenuItem menuItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(menuItem.name),
        Text('${menuItem.calories}')
      ],
    );
  }
}