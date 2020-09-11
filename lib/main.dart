import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();

  Position position;
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

  MapType _currentMapType = MapType.normal;

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
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: _currentMapType,
              markers: createMarker(),
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    position.latitude == null ? 22.3683163 : position.latitude,
                    position.longitude == null
                        ? 91.8356431
                        : position.longitude),
                zoom: 12.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton(
                  onPressed: () => setState(() => _currentMapType =
                      _currentMapType == MapType.normal
                          ? MapType.terrain
                          : MapType.normal),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.map),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
