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
    location: LatLng(30.112435840435566, 31.32374380537395),
    name: 'First Place',
  ),
  PlaceModel(
    id: '2',
    location: LatLng(30.10530785248985, 31.315418228589493),
    name: 'Second Place',
  ),
  PlaceModel(
    id: '3',
    location: LatLng(30.11807846618015, 31.30271528669155),
    name: 'Third Place',
  ),
];
