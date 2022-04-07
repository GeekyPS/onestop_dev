import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:onestop_dev/globals.dart';

class MapBox extends StatefulWidget {
  double? lat, long;
  MapBox({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<MapBox> createState() => _MapBoxState();
}

bool status = false;
DateTime now = DateTime.now();
String formattedTime = DateFormat.jm().format(now);

class _MapBoxState extends State<MapBox> {
  final MapController _mapController = MapController();
  bool mapToggle = true;
  final myToken =
      'pk.eyJ1IjoibGVhbmQ5NjYiLCJhIjoiY2t1cmpreDdtMG5hazJvcGp5YzNxa3VubyJ9.laphl_yeaw_9SUbcebw9Rg';
  final pointIcon = 'assets/images/Ellipse135.png';
  late LatLng myPos = LatLng(-37.327154, -59.119667);
  double zoom = 13.0;
  List<LatLng> latlngList = [];
  //
  void initState() {
    super.initState();
    _getLoctaion();
  }

  @override
  Widget build(BuildContext context) {
    location.onLocationChanged.listen((LocationData current) {
      _getLoctaion();
    });
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Stack(
        children: [
          Container(
            height: 365,
            width: 350,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: myPos,
                zoom: zoom,
              ),
              nonRotatedLayers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibGVhbmQ5NjYiLCJhIjoiY2t1cmpreDdtMG5hazJvcGp5YzNxa3VubyJ9.laphl_yeaw_9SUbcebw9Rg',
                  additionalOptions: {
                    'accessToken': myToken,
                    'id': 'mapbox/light-v10',
                  },
                ),
                MarkerLayerOptions(
                  markers: markers,
                ),
                PolylineLayerOptions(polylines: [
                  Polyline(
                    points: [
                      LatLng(lat, long),
                      LatLng(widget.lat!, widget.long!)
                    ],
                    // isDotted: true,
                    color: Color(0xFF669DF6),
                    strokeWidth: 3.0,
                    borderColor: Color(0xFF1967D2),
                    borderStrokeWidth: 0.1,
                  )
                ])
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    child: Container(
                      height: 32,
                      width: 83,
                      color: (selectedIndex == 0)
                          ? Color.fromRGBO(118, 172, 255, 1)
                          : Color.fromRGBO(39, 49, 65, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconData(0xe1d5, fontFamily: 'MaterialIcons'),
                            color: (selectedIndex == 0)
                                ? Color.fromRGBO(39, 49, 65, 1)
                                : Colors.white,
                          ),
                          Text(
                            "Bus",
                            style: TextStyle(
                              color: (selectedIndex == 0)
                                  ? Color.fromRGBO(39, 49, 65, 1)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    child: Container(
                      height: 32,
                      width: 83,
                      color: (selectedIndex == 1)
                          ? Color.fromRGBO(118, 172, 255, 1)
                          : Color.fromRGBO(39, 49, 65, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconData(0xefc2, fontFamily: 'MaterialIcons'),
                            color: (selectedIndex == 1)
                                ? Color.fromRGBO(39, 49, 65, 1)
                                : Colors.white,
                          ),
                          Text(
                            "Ferries",
                            style: TextStyle(
                              color: (selectedIndex == 1)
                                  ? Color.fromRGBO(39, 49, 65, 1)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    child: Container(
                      height: 32,
                      width: 83,
                      color: (selectedIndex == 2)
                          ? Color.fromRGBO(118, 172, 255, 1)
                          : Color.fromRGBO(39, 49, 65, 1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bus_alert,
                            color: (selectedIndex == 2)
                                ? Color.fromRGBO(39, 49, 65, 1)
                                : Colors.white,
                          ),
                          Text(
                            "Food",
                            style: TextStyle(
                              color: (selectedIndex == 2)
                                  ? Color.fromRGBO(39, 49, 65, 1)
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SingleChildScrollView(
          //   child: Column(
          //     children: <Widget>[
          //       CarouselSlider(
          //         items: Sliders,
          //         options: CarouselOptions(enlargeCenterPage: true, height: 100),
          //         carouselController: _controller,
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
            left: 285,
            top: 300,
            child: FloatingActionButton(
              onPressed: () {
                _mapController.moveAndRotate(LatLng(lat, long), 15, 17);
              },
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }

  Location location = new Location();
  LocationData? _locationData;
  double lat = 0;
  double long = 0;
  List<Marker> markers = [];
  Future<dynamic> _getLoctaion() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    _addMarker(_locationData!.latitude!, _locationData!.longitude!);
    setState(() {
      lat = _locationData!.latitude!;
      long = _locationData!.longitude!;
      userlat = _locationData!.latitude!;
      userlong = _locationData!.longitude!;
      mapToggle = true;
    });
  }

  void _addMarker(double lat, double long) {
    Marker marker = Marker(
      point: LatLng(lat, long),
      width: 25.0,
      height: 25.0,
      builder: (ctx) => Container(
        child: Image.asset(pointIcon),
      ),
    );
    setState(() {
      markers.add(marker);
    });
  }
}
