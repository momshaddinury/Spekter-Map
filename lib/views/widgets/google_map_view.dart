import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({
    Key key,
    @required this.currentMapType,
    @required this.position,
    this.onMapCreated,
    this.createMarker,
  });

  final MapType currentMapType;
  final Position position;
  final Function onMapCreated;
  final Set<Marker> createMarker;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      mapType: currentMapType,
      markers: createMarker,
      initialCameraPosition: CameraPosition(
        target: LatLng(
            position.latitude == null ? 22.3683163 : position.latitude,
            position.longitude == null ? 91.8356431 : position.longitude),
        zoom: 17.0,
      ),
    );
  }
}
