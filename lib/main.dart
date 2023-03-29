import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places_collection.dart';

import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(primarySwatch: Colors.indigo);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: PlacesCollection(),
      child: MaterialApp(
        title: 'Rememories',
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber)),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
