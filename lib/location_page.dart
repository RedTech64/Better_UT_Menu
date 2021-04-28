import 'package:Better_UT_Menu/meal_page.dart';
import 'package:Better_UT_Menu/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// This is the page that shows the list of dining locations

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Longhorn Dining'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AboutDialog(
                  applicationName: 'Longhorn Dining',
                  applicationIcon: Image.asset('assets/logo.png', width: 64,),
                  children: [
                    Text('For comments and feedback, please email coleweinman@utexas.edu')
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<Location> locations = snapshot.data.docs.map((locationDoc) => Location.fromJSON(locationDoc.data())).toList();
          return Scrollbar(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 500,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.asset('assets/logo.png'),
                      )
                    ),
                    Container(
                      width: 500,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Location location = locations[index];
                          return Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              child: Image.asset('assets/${location.id}.png'),
                              onTap: () {
                                Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (context) => MealPage(location),
                                ));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}