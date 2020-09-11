import 'package:geolocator/geolocator.dart';

class Location {
  Position position;

  Future getCurrentLocation() async {
    Position _position = await getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    position = _position;
    return position;
  }
}
