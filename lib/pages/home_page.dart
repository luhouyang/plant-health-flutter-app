import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:plant_health_data/entities/plant_entity.dart';
import 'package:plant_health_data/pages/add_plant.dart';
import 'package:plant_health_data/services/excel_sheets/excel_service.dart';
import 'package:plant_health_data/services/location/location_service.dart';
import 'package:plant_health_data/shared/widgets/loading_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PlantEntity> plantList = [];

  final StreamController<void> _rebuildStream = StreamController.broadcast();
  FlutterMap? map;

  Future<void> loadData() async {
    plantList = await ExcelService().loadData();
    _getMap();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _rebuildStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // map with previous plant
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "All Your Plants",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: map ??
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: LoadingAnimationWidget.hexagonDots(color: Colors.green, size: 75),
                            ),
                            const LoadingTextWidget()
                          ],
                        ),
                  ),
                ),
              ],
            ),
          ),
          if (plantList.isEmpty)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.green[900],
                      foregroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddPlantPage(),
                      ));
                    },
                    child: const Text(
                      "Click To Add Plant",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.green[900],
                foregroundColor: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                await loadData();
              },
              child: const Text(
                "Reload",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _getMap() async {
    // get geo location
    LocationData location = await LocationService().getLiveLocation();
    if (!mounted) return;
    setState(() {
      // create hybrid map
      map = FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(location.latitude!, location.longitude!),
          initialZoom: 18.0,
        ),
        children: [
          TileLayer(
            retinaMode: true, tileProvider: NetworkTileProvider(headers: {'User-Agent': 'com.planthealthdtc.plant_health_data/1.1.3'}),
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            // userAgentPackageName: "com.planthealthdtc.plant_health_data/flutter_map/7.0.2",
          ),
          // live location, orientation tracker
          LocationService().currerntLocationandOrientation(),
          if (plantList.isNotEmpty)
            MarkerLayer(
              markers: plantList.map((plantEntity) {
                return Marker(
                    point: LatLng(plantEntity.location.latitude, plantEntity.location.longitude),
                    width: 80,
                    height: 80,
                    child: InkWell(
                        onHover: (val) {},
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    backgroundColor: Colors.white,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          plantEntity.label,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: MemoryImage(plantEntity.imageData),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      //TODO: direct to group page
                                      TextButton(
                                        child: const Text(
                                          'View Group',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ]);
                              });
                        },
                        child: Stack(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 50.0,
                            ),
                            Positioned(
                              top: 7,
                              left: 9,
                              child: SizedBox(
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.memory(plantEntity.imageData),
                                ),
                              ),
                            ),
                            Positioned(top: 0, child: Text(plantEntity.label)),
                          ],
                        )));
              }).toList(),
            )
        ],
      );
    });
  }
}
