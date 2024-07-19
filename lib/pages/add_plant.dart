import 'package:flutter/material.dart';
import 'package:plant_health_data/shared/controllers/my_controllers.dart';
import 'package:plant_health_data/shared/enums/my_enums.dart';
import 'package:plant_health_data/shared/widgets/my_checkbox_image.dart';
import 'package:plant_health_data/shared/widgets/my_h1.dart';
import 'package:plant_health_data/shared/widgets/my_percentage.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final _formKey = GlobalKey<FormState>();

  // chlorosis
  TextEditingController youngLeavesChlorosisController = TextEditingController();
  TextEditingController oldLeavesChlorosisController = TextEditingController();
  BoolEditingController entirePlantChlorosisController = BoolEditingController();
  BoolEditingController leavesEdgeChlorosisController = BoolEditingController();
  BoolEditingController leavesTipChlorosisController = BoolEditingController();
  BoolEditingController spotsChlorosisController = BoolEditingController();
  BoolEditingController completeInterveinalChlorosisController = BoolEditingController();
  BoolEditingController partialInterveinalChlorosisCotroller = BoolEditingController();
  BoolEditingController leavesVeinChlorosisController = BoolEditingController();

  // dark/pale green
  BoolEditingController deepGreenYoungLeavesController = BoolEditingController();
  BoolEditingController deepGreenOldLeavesController = BoolEditingController();
  BoolEditingController paleGreenLeavesController = BoolEditingController();

  // leaf structure
  BoolEditingController rollCurlingLeavesController = BoolEditingController();
  BoolEditingController flaccidLeavesController = BoolEditingController();

  // growth
  BoolEditingController witchesBroomController = BoolEditingController();
  BoolEditingController diebackController = BoolEditingController();

  // brown/ash colour
  BoolEditingController leavesEdgeBrownAshController = BoolEditingController();
  BoolEditingController spotsBrownAshController = BoolEditingController();
  BoolEditingController leavesTipBrownAshController = BoolEditingController();

  // red/purple colour
  BoolEditingController leavesEdgeRedPurpleController = BoolEditingController();
  BoolEditingController spotsRedPurpleController = BoolEditingController();
  BoolEditingController leavesTipRedPurpleController = BoolEditingController();
  BoolEditingController leavesVeinRedPurpleController = BoolEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, TextEditingController> textControllerList = {
      // chlorosis
      PlantCharacteristics.youngLeavesChlorosis.value: youngLeavesChlorosisController,
      PlantCharacteristics.oldLeavesChlorosis.value: oldLeavesChlorosisController,
    };

    Map<String, BoolEditingController> boolControllerList = {
      // chlorosis
      PlantCharacteristics.entirePlantChlorosis.value: entirePlantChlorosisController,
      PlantCharacteristics.leavesEdgeChlorosis.value: leavesEdgeChlorosisController,
      PlantCharacteristics.leavesTipChlorosis.value: leavesTipChlorosisController,
      PlantCharacteristics.spotsChlorosis.value: spotsChlorosisController,
      PlantCharacteristics.completeInterveinalChlorosis.value: completeInterveinalChlorosisController,
      PlantCharacteristics.partialInterveinalChlorosis.value: partialInterveinalChlorosisCotroller,
      PlantCharacteristics.leavesVeinChlorosis.value: leavesVeinChlorosisController,

      // dark/pale green
      PlantCharacteristics.deepGreenYoungLeaves.value: deepGreenYoungLeavesController,
      PlantCharacteristics.deepGreenOldLeaves.value: deepGreenOldLeavesController,
      PlantCharacteristics.paleGreenLeaves.value: paleGreenLeavesController,

      // leaf structure
      PlantCharacteristics.rollCurlingLeaves.value: rollCurlingLeavesController,
      PlantCharacteristics.flaccidLeaves.value: flaccidLeavesController,

      // growth
      PlantCharacteristics.witchesBroom.value: witchesBroomController,
      PlantCharacteristics.dieback.value: diebackController,

      // brown/ash colour
      PlantCharacteristics.leavesEdgeBrownAsh.value: leavesEdgeBrownAshController,
      PlantCharacteristics.spotsBrownAsh.value: spotsBrownAshController,
      PlantCharacteristics.leavesTipBrownAsh.value: leavesTipBrownAshController,

      // red/purple colour
      PlantCharacteristics.leavesEdgeRedPurple.value: leavesEdgeRedPurpleController,
      PlantCharacteristics.spotsRedPurple.value: spotsRedPurpleController,
      PlantCharacteristics.leavesTipRedPurple.value: leavesTipRedPurpleController,
      PlantCharacteristics.leavesVeinRedPurple.value: leavesVeinRedPurpleController,
    };

    double height = 0.75;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        iconTheme: const IconThemeData(color: Colors.green),
        title: const Text(
          "Add Plant",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // chlorosis section
                // young leaves %, old leaves %
                // entire plant, leaf edges, leaf tips, spots
                // interveinal (complete), interveinal (partial), vein
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Chlorosis/Yellowing"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                MyPercentage(
                  hint: "Average % Young Leaves Chlorosis",
                  imageAsset: "assets/sample_images/youngLeavesChlorosis.webp",
                  controller: youngLeavesChlorosisController,
                ),
                MyPercentage(
                  hint: "Average % Old Leaves Chlorosis",
                  imageAsset: "assets/sample_images/oldLeavesChlorosis.jpg",
                  controller: oldLeavesChlorosisController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Entire Plane Chlorosis",
                        imageAsset: "assets/sample_images/entirePlantChlorosis.webp",
                        controller: entirePlantChlorosisController,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Edge Chlorosis",
                        imageAsset: "assets/sample_images/leavesEdgeChlorosis.jpg",
                        controller: leavesEdgeChlorosisController,
                      ),
                      MyCheckboxImage(
                        text: "Spots Chlorosis",
                        imageAsset: "assets/sample_images/spotsChlorosis.jpg",
                        controller: spotsChlorosisController,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Tips Chlorosis",
                        imageAsset: "assets/sample_images/leavesTipChlorosis.jpg",
                        controller: leavesTipChlorosisController,
                      ),
                      MyCheckboxImage(
                        text: "Complete Interveinal Chlorosis",
                        imageAsset: "assets/sample_images/completeInterveinalChlorosis.jpg",
                        controller: completeInterveinalChlorosisController,
                      ),
                      MyCheckboxImage(
                        text: "Partial Interveinal Chlorosis",
                        imageAsset: "assets/sample_images/partialInterveinalChlorosis.jpg",
                        controller: partialInterveinalChlorosisCotroller,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Vein Chlorosis",
                        imageAsset: "assets/sample_images/leavesVeinChlorosis.webp",
                        controller: leavesVeinChlorosisController,
                      ),
                    ],
                  ),
                ),

                // dark/pale green section
                // deep green old, deep green young
                // pale green leaves
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Dark/Pale Green Leaves"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Deep Green Young Leaves",
                        imageAsset: "assets/sample_images/deepGreenYoungLeaves.webp",
                        controller: deepGreenYoungLeavesController,
                      ),
                      MyCheckboxImage(
                        text: "Deep Green Old Leaves",
                        imageAsset: "assets/sample_images/youngLeavesChlorosis.webp",
                        controller: deepGreenOldLeavesController,
                      ),
                      MyCheckboxImage(
                        text: "Pale Green Leaves",
                        imageAsset: "assets/sample_images/paleGreenLeaves.webp",
                        controller: paleGreenLeavesController,
                      ),
                    ],
                  ),
                ),

                // leaf structure
                // roll/curling leaves, flaccid leaves
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Leaves Structure"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Roll Curling Leaves",
                        imageAsset: "assets/sample_images/rollCurlingLeaves.jpg",
                        controller: rollCurlingLeavesController,
                      ),
                      MyCheckboxImage(
                        text: "Flaccid Leaves",
                        imageAsset: "assets/sample_images/flaccidLeaves.jpg",
                        controller: flaccidLeavesController,
                      ),
                    ],
                  ),
                ),

                // growth
                // witches' broom, die-back
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Plant Growth"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Witches' Broom",
                        imageAsset: "assets/sample_images/witchesBroom.webp",
                        controller: witchesBroomController,
                      ),
                      MyCheckboxImage(
                        text: "Die-back",
                        imageAsset: "assets/sample_images/dieback.jpg",
                        controller: diebackController,
                      ),
                    ],
                  ),
                ),

                // brown/ash colour
                // leaf edges, leaf tips, spots
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Brown/Ash Leaves"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Leaves Edges Brown/Ash",
                        imageAsset: "assets/sample_images/leavesEdgeBrownAsh.webp",
                        controller: leavesEdgeBrownAshController,
                      ),
                      MyCheckboxImage(
                        text: "Spots Brown/Ash",
                        imageAsset: "assets/sample_images/spotsBrownAsh.jpg",
                        controller: spotsBrownAshController,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Tips Brown/Ash",
                        imageAsset: "assets/sample_images/leavesTipBrownAsh.jpg",
                        controller: leavesTipBrownAshController,
                      ),
                    ],
                  ),
                ),

                // red/purple colour
                // leaf edges, leaf tips, spots, vein
                const Align(
                  alignment: Alignment.centerLeft,
                  child: MyH1(text: "Red/Purple Leaves"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[900],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * height,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      MyCheckboxImage(
                        text: "Leaves Edges Red/Purple",
                        imageAsset: "assets/sample_images/leavesEdgeRedPurple.jpg",
                        controller: leavesEdgeRedPurpleController,
                      ),
                      MyCheckboxImage(
                        text: "Spots Red/Purple",
                        imageAsset: "assets/sample_images/spotsRedPurple.jpg",
                        controller: spotsRedPurpleController,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Tips Red/Purple",
                        imageAsset: "assets/sample_images/leavesTipRedPurple.webp",
                        controller: leavesTipRedPurpleController,
                      ),
                      MyCheckboxImage(
                        text: "Leaves Vein Red/Purple",
                        imageAsset: "assets/sample_images/leavesVeinRedPurple.jpg",
                        controller: leavesVeinRedPurpleController,
                      ),
                    ],
                  ),
                ),

                // sumbit button
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 30),
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
                      // validation
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
