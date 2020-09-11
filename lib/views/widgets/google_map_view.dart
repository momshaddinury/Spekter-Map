import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapView extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("Home"),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
              title:
                  "Momshad [Lat: ${position.latitude}, Lon: ${position.longitude}]"))
    ].toSet();
  }

  GoogleMapView({
    Key key,
    @required this.currentMapType,
    @required this.position,
  });

  final MapType currentMapType;
  final Position position;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: currentMapType,
      markers: createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17.0,
      ),
    );
  }
}
