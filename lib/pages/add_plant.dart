import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:plant_health_data/entities/plant_entity.dart';
import 'package:plant_health_data/services/decision_tree/dart_tree.dart';
import 'package:plant_health_data/services/excel_sheets/excel_service.dart';
import 'package:plant_health_data/services/location/location_service.dart';
import 'package:plant_health_data/shared/controllers/my_controllers.dart';
import 'package:plant_health_data/shared/enums/my_enums.dart';
import 'package:plant_health_data/shared/widgets/loading_text.dart';
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

  // image picking and cropping
  File? picFile;
  Uint8List? picBytes;

  dynamic pickImageError;
  String? retrieveDataError;

  final ImagePicker picker = ImagePicker();

  // crop selected image
  Future cropImage(XFile pickedFile) async {
    try {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          maxHeight: 1080,
          maxWidth: 1080,
          compressFormat: ImageCompressFormat.jpg, // maybe change later, test quality first
          compressQuality: 30,
          aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

      picFile = File(croppedFile!.path);
      picBytes = await picFile!.readAsBytes();

      debugPrint(picFile!.path);
      debugPrint(picFile!.lengthSync().toString());

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // pick image from gallery
  Future getImageFromGallery() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        cropImage(pickedFile);
      }
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  // take picture with camera
  Future getImageFromCamera() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        cropImage(pickedFile);
      }
    } catch (e) {
      setState(() {
        pickImageError = e;
      });
    }
  }

  // ui component for pick image button
  Widget pickImageContainer() {
    return picBytes == null
        // no image selected view
        ? Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), border: Border.all(color: Colors.black)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: IconButton(
                                onPressed: () async {
                                  getImageFromGallery();
                                },
                                tooltip: 'Pick Image from gallery or Camera',
                                icon: const Icon(Icons.photo),
                              ),
                            ),
                            const Text("Gallery"),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: IconButton(
                                onPressed: () async {
                                  getImageFromCamera();
                                },
                                icon: const Icon(Icons.camera),
                              ),
                            ),
                            const Text("Camera"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        // image selected view
        : Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), border: Border.all(color: Colors.black)),
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: Image.memory(picBytes!),
                      ),
                    ),
                    Positioned(
                      top: -11,
                      left: -11,
                      child: IconButton(
                        onPressed: () {
                          picFile = null;
                          picBytes = null;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  // error handling image
  Widget previewImages() {
    if (retrieveDataError != null) {
      //return retrieveError;
    }
    if (pickImageError != null) {
      // Pick imageError;
    }
    return pickImageContainer();
  }

  // incase app crashes, previous image data can be retrieved
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
        } else {
          picFile = response.files!.first as File?;
        }
      });
    } else {
      retrieveDataError = response.exception!.code;
    }
  }

  // image picking widget
  Widget imagePickerWidget() {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android
        ? FutureBuilder<void>(
            future: retrieveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return pickImageContainer();
                case ConnectionState.done:
                  return previewImages();
                case ConnectionState.active:
                  if (snapshot.hasError) {
                    return pickImageContainer();
                  } else {
                    return pickImageContainer();
                  }
                default:
                  return pickImageContainer();
              }
            },
          )
        : previewImages();
  }
  // end of pictures code

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
                const Text(
                  "Pick an Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                imagePickerWidget(),

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

                        List<double> input = PlantNutritionDecisionTree.formatInput(textControllerList, boolControllerList);
                        List<double> predictionOHEA = PlantNutritionDecisionTree.predictNutrientDeficiency(input);
                        String predictionStr = PlantNutritionDecisionTree.getClass(predictionOHEA);

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Dialog(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      predictionStr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(16),
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
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return Dialog(
                                              child: Column(
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
                                            );
                                          },
                                        );
                                        await LocationService().getLiveLocation().then((LocationData locationData) async {
                                          if (locationData.latitude != null && locationData.longitude != null) {
                                            PlantEntity plantEntity = PlantEntity.fromMaps(
                                              percentageController: textControllerList,
                                              boolController: boolControllerList,
                                              location: LatLng(locationData.latitude!, locationData.longitude!),
                                              imageData: picBytes!,
                                              label: predictionStr
                                            );

                                            await ExcelService()
                                                .saveData(plantEntity)
                                                .then(
                                              (value) {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          } else {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          }
                                        });
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
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
