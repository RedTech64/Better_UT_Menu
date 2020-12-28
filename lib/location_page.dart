import 'package:Better_UT_Menu/meal_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the page that shows the list of dining locations

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          List<DocumentSnapshot> locationDocs = snapshot.data.docs;
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot locationDoc = locationDocs[index];
              return Card(
                child: InkWell(
                  child: Text(
                    locationDoc['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => MealPage(locationDoc.id),
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