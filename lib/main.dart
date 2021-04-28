import 'package:Better_UT_Menu/location_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color.fromRGBO(215, 129, 69, 1.0),
      cardTheme: CardTheme(
        elevation: 8
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Color.fromRGBO(215, 129, 69, 1.0)),
        trackColor: MaterialStateProperty.all(Color.fromRGBO(215, 129, 69, 0.5))
      )
      // cardTheme: CardTheme(
      //   elevation: 0,
        
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     side: BorderSide(
      //       color: Colors.grey.withOpacity(0.4),
      //       width: 1,
      //     ),
      //   )
      // ),
    ),
    home: LocationPage(),
  ));
}
