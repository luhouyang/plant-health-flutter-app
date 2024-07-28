import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:plant_health_data/services/decision_tree/dart_tree.dart';

import '../shared/controllers/my_controllers.dart';

class PlantEntity {
  List<double> features;
  String label;
  LatLng location;
  Uint8List imageData;

  PlantEntity({
    required this.features,
    required this.label,
    required this.location,
    required this.imageData,
  });

  factory PlantEntity.fromMaps({
    required Map<String, TextEditingController> percentageController,
    required Map<String, BoolEditingController> boolController,
    required LatLng location,
    required Uint8List imageData,
    required String label,
  }) {
    return PlantEntity(
        features: PlantNutritionDecisionTree.formatInput(percentageController, boolController), location: location, imageData: imageData, label: label);
  }
}
