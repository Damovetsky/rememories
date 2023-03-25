import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlacesCollection with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImmage,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImmage,
        location: null,
        title: pickedTitle);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesData = await DBHelper.getData('user_places');
    _items = placesData
        .map(
          (item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: null,
            title: item['title'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
