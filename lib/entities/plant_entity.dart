import 'dart:typed_data';
import 'package:latlong2/latlong.dart';

class PlantEntity {
  String plantName;
  List<dynamic> data;
  LatLng location;
  String photoPath;
  Uint8List imageData;

  PlantEntity({
    required this.plantName,
    required this.data,
    required this.location,
    required this.photoPath,
    required this.imageData,
  });
}
