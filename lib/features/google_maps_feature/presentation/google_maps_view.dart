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
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target: LatLng(30.112435840435566, 31.32374380537395),
      zoom: 12.0,
    );
    initMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
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
}
