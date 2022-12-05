import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];
  final tableName = 'places';

  List<Place> get places {
    return [..._places];
  }

  Future<void> fetchPlaces() async {
    final data = await DBHelper.getPlaces(tableName);
    _places = data
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            image: File(place['image'].toString()),
            location: Location(address: '', latitude: 0.0, logitude: 0.0),
          ),
        )
        .toList();
    notifyListeners();
  }

  void addPlace(Place place) {
    _places.add(place);
    notifyListeners();
    DBHelper.insert(tableName, {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
    });
  }
}
