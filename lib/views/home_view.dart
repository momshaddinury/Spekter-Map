import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'widgets/change_map_type_button.dart';
import 'widgets/google_map_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Completer<GoogleMapController> _controller = Completer();
  Position position;
  MapType _currentMapType = MapType.normal;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void getCurrentLocation() async {
    Position _position = await getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print(_position);
    setState(() {
      position = _position;
    });
  }

  void changeMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.terrain : MapType.normal;
    });
  }

  Set<Marker> createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("Home"),
          position: LatLng(position.latitude ?? 22.3683163,
              position.longitude ?? 91.8356431),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title:
                  "Momshad [Lat: ${position.latitude}, Lon: ${position.longitude}]"))
    ].toSet();
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Spekter Map View'),
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: [
            GoogleMapView(
              currentMapType: _currentMapType,
              position: position,
              onMapCreated: _onMapCreated,
              createMarker: createMarker(),
            ),
            ChangeMapTypeButton(changeMapType: changeMapType),
          ],
        ),
      ),
    );
  }
}
