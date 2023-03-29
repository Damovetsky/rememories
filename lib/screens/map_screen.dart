import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 59.9268, longitude: 30.338),
    this.isSelecting = false,
    Key key,
  }) : super(key: key);

  final PlaceLocation initialLocation;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  YandexMapController _mapController;
  final List<MapObject> _mapObjects = [];
  Point _pickedLocation;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (!widget.isSelecting) {
      _placeMarker(
        Point(
            latitude: widget.initialLocation.latitude,
            longitude: widget.initialLocation.longitude),
      );
    }
    super.initState();
  }

  void _placeMarker(Point position) {
    final mapObject = PlacemarkMapObject(
      mapId: MapObjectId('Location marker'),
      point: Point(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
      opacity: 0.7,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('lib/assets/images/place.png'),
          scale: 1.2,
        ),
      ),
    );
    _pickedLocation = position;

    setState(() {
      _mapObjects.add(mapObject);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: YandexMap(
        onMapTap: widget.isSelecting
            ? (position) {
                _placeMarker(position);
              }
            : null,
        mapObjects: _mapObjects,
        onMapCreated: (controller) {
          _mapController = controller;
          _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: widget.initialLocation.latitude,
                  longitude: widget.initialLocation.longitude,
                ),
                zoom: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
