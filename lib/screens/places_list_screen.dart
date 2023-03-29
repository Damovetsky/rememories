import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/places_collection.dart';
import '../widgets/add_new_place.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesCollection>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlacesCollection>(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Got no places yet, try adding some!',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      AddNewPlaceButton(),
                    ],
                  ),
                ),
                builder: (ctx, placesCollection, ch) =>
                    placesCollection.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: placesCollection.items.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(placesCollection.items[i].image),
                              ),
                              title: Text(placesCollection.items[i].title),
                              subtitle: Text(
                                  placesCollection.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: placesCollection.items[i].id);
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
