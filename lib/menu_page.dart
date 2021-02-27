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
            child: _getColumns(),
          ),
        ),
      ),
    );
  }

  Widget _getColumns() {
    List<Widget> firstColumnChildren = [];
    for (Line line in meal.lines) {
      firstColumnChildren.add(
        Container(
          width: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      line.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: line.items.length,
                    itemBuilder: (context, itemIndex) => _getMenuItemRow(line.items[itemIndex], context),
                    separatorBuilder: (context, index) => Divider(height: 0),
                  ),
                ],
              ),
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

  List<Widget> _getFlagWidets(MenuItem menuItem) {
    List<Widget> flagWidgets = [];
    List<List<dynamic>> flags = [
      [menuItem.beef, 'assets/beef.png', 'Beef'],
      [menuItem.liteBites, 'assets/lite_bites.png', 'Lite Bites'],
      [menuItem.milk, 'assets/milk.png', 'Milk'],
      [menuItem.pork, 'assets/pork.png', 'Pork'],
      [menuItem.shellfish, 'assets/shellfish.png', 'Shellfish'],
      [menuItem.soy, 'assets/soy.png', 'Soy'],
      [menuItem.treeNuts, 'assets/tree_nuts.png', 'Tree Nuts'],
      [menuItem.vegan, 'assets/vegan.png', 'Vegan'],
      [menuItem.veggie, 'assets/veggie.png', 'Veggie'],
      [menuItem.wheat, 'assets/wheat.png', 'Wheat'],
    ];
    for (List<dynamic> flag in flags) {
      if (flag[0]) {
        flagWidgets.add(
          Tooltip(
            message: flag[2],
            child: Image.asset(flag[1], width: FLAG_SIZE, height: FLAG_SIZE),
          )
        );
        flagWidgets.add(Container(width: 8));
      }
    }
    return flagWidgets;
  }

  // Returns a menu item and it's info along with actions
  Widget _getMenuItemRow(MenuItem menuItem, BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(menuItem.name),
          Container(width: 8),
          ..._getFlagWidets(menuItem)
        ],
      ),
      dense: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(menuItem.calories.toString()),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => MenuItemDialog(menuItem),
              );
            },
          ),
        ],
      ),
    );
  }
}