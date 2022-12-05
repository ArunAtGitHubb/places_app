import 'package:flutter/material.dart';
import 'package:great_places/pages/add_place.dart';
import 'package:great_places/pages/places_list.dart';
import 'package:great_places/providers/places.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: const Color(0xff2F4858),
        ),
        home: const PlacesPage(),
        routes: {
          AddPlacePage.route: (_) => const AddPlacePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
