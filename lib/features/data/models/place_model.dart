import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String id;
  final LatLng location;
  final String name;

  PlaceModel({required this.id, required this.location, required this.name});
}

List<PlaceModel> places = [
  PlaceModel(
    id: '1',
    location: LatLng(30.13762295429833, 31.272014316994024),
    name: 'First Place',
  ),
  PlaceModel(
    id: '2',
    location: LatLng(30.13762295429833, 32.272014316994024),
    name: 'Second Place',
  ),
  PlaceModel(
    id: '3',
    location: LatLng(30.13762295429833, 33.272014316994024),
    name: 'Third Place',
  ),
];
