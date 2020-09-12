# Spekter_Map
 
### A simple application that uses 'google_maps_flutter' package to show show Google map. 
### This also tracks users location and places a marker.

### Functionality:

- Loading Screen as service fetches the location
- Google Map Location of users Current Location
- Marker
- Change Map Type Button
- On Tap of Marker Shows InfoWindow with users Lat Lon.

### How to guide:

The first step is to add the Google Maps Flutter plugin as a dependency in the pubspec.yaml file. The package is available as google_maps_flutter on pub.dartlang.org.

Once you do that, you need to run flutter packages get.
The next step is getting an API key for both Android and iOS. For Android, follow the instructions at [Maps SDK for Android — Get API Key][Get Api Key]. Once you have your API key, add it to your Flutter app in the application manifest (android/app/src/main/AndroidManifest.xml), as follows:

```<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR ANDROID API KEY HERE"/>
```

Now you are ready to add a GoogleMap widget! Run flutter clean to make sure the API key changes are picked up on the next build

### Folder Structure:
```
lib-
    - services
       - location.dart
    - views
        - widgets
            - change_map_type_button.dart
            - google_map_view.dart
        - home_view.dart
    - main.dart
```

### Packages uses:

```
google_maps_flutter: ^0.5.32
permission_handler: ^5.0.1+1
geolocator: ^6.0.0+4
```

### Starting Code File:

- home_view.dart
```
Scaffold(
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
      )
```

[Get Api Key]: https://developers.google.com/maps/documentation/android-sdk/get-api-key

