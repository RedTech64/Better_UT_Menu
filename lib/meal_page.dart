import 'package:Better_UT_Menu/menu_page.dart';
import 'package:Better_UT_Menu/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the page that shows the different meals served at a location (Breakfast, lunch, dinner)

class MealPage extends StatelessWidget {
  Location location;

  MealPage(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: Center(
        child: Container(
          width: 400,
          child: ListView.builder(
            itemCount: location.mealNames.length,
            itemBuilder: (context, index) {
              String name = location.mealNames[index];
              return Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  child: Image.asset('assets/$name.png'),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => MenuPage(location, name),
                    ));
                  },
                ),
              );
            },
          ),
        )
      ),
    );
  }
}