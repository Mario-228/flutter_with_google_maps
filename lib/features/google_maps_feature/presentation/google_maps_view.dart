import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/features/data/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  late GoogleMapController googleMapController;
  late CameraPosition initialCameraPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(30.112435840435566, 31.32374380537395),
      zoom: 12.0,
    );
    initMarkers();
    initPolyLines();
    initPolygons();
    initCircles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            circles: circles,
            polygons: polygons,
            polylines: polylines,
            markers: markers,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
            },
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(29.54731017799475, 30.51146816015295),
                northeast: LatLng(30.377164022482987, 31.63495689305018),
              ),
            ),
            initialCameraPosition: initialCameraPosition,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  CameraPosition newCameraPosition = CameraPosition(
                    target: LatLng(30.13762295429833, 31.272014316994024),
                    zoom: 19.0,
                  );
                  googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(newCameraPosition),
                  ); //Move the camera to a specific CameraPosition

                  // googleMapController.animateCamera(
                  //   CameraUpdate.newLatLngZoom(
                  //     LatLng(40.13762295429833, 31.272014316994024),
                  //     15,
                  //   ),
                  // ); //Move the camera to a LatLng location and set the zoom level

                  // googleMapController.animateCamera(
                  //   CameraUpdate.newLatLng(
                  //     LatLng(40.13762295429833, 31.272014316994024),
                  //   ),
                  // ); //Move the camera to a specific LatLng

                  // googleMapController.animateCamera(
                  //   CameraUpdate.zoomTo(15),
                  // ); //Set the zoom level to 15

                  // googleMapController.animateCamera(
                  //   CameraUpdate.zoomOut(),
                  // ); //Decrease the zoom level by 1

                  // googleMapController.animateCamera(
                  //   CameraUpdate.zoomIn(),
                  // ); //Increase the zoom level by 1
                },
                height: 40.0,
                minWidth: 100.0,
                color: Colors.yellow,
                child: const Text('Change Location'),
              ),
              MaterialButton(
                onPressed: () {
                  initPolyLines();
                  initPolygons();
                  initCircles();
                  setState(() {});
                },
                height: 40.0,
                minWidth: 100.0,
                color: Colors.green,
                child: const Text('refresh'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> initMapStyle() async {
    String retroMapStyle = await DefaultAssetBundle.of(context).loadString(
      'assets/map_styles/retro_map_style.json',
    ); //to load the json file in String variable
    await googleMapController.setMapStyle(retroMapStyle);
  }

  void initMarkers() async {
    BitmapDescriptor markerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      "assets/images/maps-and-flags.png",
      height: 30.0,
      width: 30.0,
    );
    markers =
        places
            .map(
              (place) => Marker(
                icon: markerIcon,
                markerId: MarkerId(place.id),
                position: place.location,
                infoWindow: InfoWindow(title: place.name),
              ),
            )
            .toSet();
    setState(() {});
  }

  void initPolyLines() {
    polylines.add(
      Polyline(
        startCap: Cap.roundCap,
        zIndex: 0,
        width: 5,
        color: Colors.green,
        polylineId: const PolylineId('1'),
        points: [
          LatLng(30.112435840435566, 31.32374380537395),
          LatLng(30.10530785248985, 31.315418228589493),
          LatLng(30.11807846618015, 31.30271528669155),
        ],
      ),
    );
    polylines.add(
      Polyline(
        geodesic: true,
        patterns: [PatternItem.dash(10), PatternItem.gap(10)],
        startCap: Cap.roundCap,
        zIndex: 1,
        width: 5,
        color: Colors.red,
        polylineId: const PolylineId('2'),
        points: [
          LatLng(30.11735125863466, 31.316128061107573),
          LatLng(30.104393872551388, 31.3147428464857),
        ],
      ),
    );
  }

  void initPolygons() {
    polygons.add(
      Polygon(
        holes: [
          [
            const LatLng(30.20, 31.10),
            const LatLng(30.20, 31.50),
            const LatLng(30.40, 31.50),
            const LatLng(30.40, 31.10),
          ],
          [
            const LatLng(29.95, 31.23),
            const LatLng(29.95, 31.30),
            const LatLng(30.00, 31.30),
            const LatLng(30.00, 31.23),
          ],
          [
            const LatLng(30.09, 31.30),
            const LatLng(30.09, 31.35),
            const LatLng(30.13, 31.35),
            const LatLng(30.13, 31.30),
          ],
          [
            const LatLng(30.05, 31.35),
            const LatLng(30.05, 31.42),
            const LatLng(30.10, 31.42),
            const LatLng(30.10, 31.35),
          ],
        ],
        polygonId: const PolygonId('1'),
        points: [
          const LatLng(31.6, 25.0),
          const LatLng(31.3, 34.25),
          const LatLng(22.0, 36.9),
          const LatLng(22.0, 25.0),
        ],
        strokeWidth: 3,
        fillColor: Colors.transparent,
        strokeColor: Colors.green,
      ),
    );
  }

  void initCircles() {
    circles.add(
      Circle(
        circleId: const CircleId('1'),
        center: const LatLng(30.112435840435566, 31.32374380537395),
        radius: 1000,
        strokeWidth: 3,
        strokeColor: Colors.green,
        fillColor: Colors.red.withValues(alpha: 0.5),
      ),
    );
  }
}
