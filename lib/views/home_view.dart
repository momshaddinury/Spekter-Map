import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spekter_map/services/location.dart';

import 'widgets/change_map_type_button.dart';
import 'widgets/google_map_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Location _location = Location();
  MapType _currentMapType = MapType.normal;

  void changeMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.terrain : MapType.normal;
    });
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
        body: FutureBuilder(
          future: _location.getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  GoogleMapView(
                    currentMapType: _currentMapType,
                    position: snapshot.data,
                  ),
                  ChangeMapTypeButton(changeMapType: changeMapType),
                ],
              );
            } else {
              print("${snapshot.data}");
            }
            return Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
            );
          },
        ),
      ),
    );
  }
}
