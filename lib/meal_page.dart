import 'package:Better_UT_Menu/menu_page.dart';
import 'package:Better_UT_Menu/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the page that shows the different meals served at a location (Breakfast, lunch, dinner)

class MealPage extends StatelessWidget {
  String locationID;

  MealPage(this.locationID);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    // Date string used to search documents for today's meals
    String dateString = '${date.month}/${date.day}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
          .collection('locations')
          .doc(locationID)
          .collection('meals')
          .where('dateString', isEqualTo: dateString).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<Meal> meals = snapshot.data.docs.map((doc) => Meal.fromJSON(doc.data())).toList().cast<Meal>();
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              Meal meal = meals[index];
              return Card(
                child: InkWell(
                  child: Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => MenuPage(meal),
                    ));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}