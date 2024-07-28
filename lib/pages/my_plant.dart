import 'package:flutter/material.dart';
import 'package:plant_health_data/entities/plant_entity.dart';
import 'package:plant_health_data/services/excel_sheets/excel_service.dart';

class MyPlantPage extends StatefulWidget {
  const MyPlantPage({super.key});

  @override
  State<MyPlantPage> createState() => _MyPlantPageState();
}

class _MyPlantPageState extends State<MyPlantPage> {
  final List<String> featureList = [
    "Young Leaves Chlorosis",
    "Old Leaves Chlorosis",
    "Entire Plant Chlolosis",
    "Leaves Edge Chlorosis",
    "Spots Chlorosis",
    "Leaves Tip Chlorosis",
    "Complete Interveinal Chlorosis",
    "Partial Interveinal Chlorosis",
    "Leaves Vein Chlorosis",
    "Deep Green Young Leaves",
    "Deep Green Old Leaves",
    "Pale Green Leaves",
    "Roll Curling Leaves",
    "Flaccid Leaves",
    "Witches Broom",
    "Dieback",
    "Leaves Edge Brown Ash",
    "Spots Brown Ash",
    "Leaves Tip Brown Ash",
    "Leaves Edge Red Purple",
    "Spots Red Purple",
    "Leaves Tip Red Purple",
    "Leaves Vein Red Purple"
  ];

  List<PlantEntity> plantList = [];

  Future<void> loadData() async {
    plantList = await ExcelService().loadData();
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
  Widget build(BuildContext context) {
    // all previous plant
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: plantList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.lightGreen[100]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Text(
                      //   plantList[index].label,
                      //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          image: DecorationImage(
                            image: MemoryImage(plantList[index].imageData),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          plantList[index].label,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[900]),
                        ),
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                        textColor: Colors.green,
                        iconColor: Colors.green[900],
                        collapsedIconColor: Colors.green[900],
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: plantList[index].features.length,
                            itemBuilder: (context, inIndex) {
                              if (inIndex == 0 || inIndex == 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${featureList[inIndex]}: ${plantList[index].features[inIndex]}%",
                                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                                      )
                                    ],
                                  ),
                                );
                              }

                              return Row(
                                children: [
                                  Text(
                                    featureList[inIndex],
                                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  Checkbox(
                                    value: plantList[index].features[inIndex] == 1.0 ? true : false,
                                    onChanged: (value) => (),
                                    activeColor: Colors.green,
                                    checkColor: Colors.white,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
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
            height: 25,
          ),
        ],
      ),
    );
  }
}
