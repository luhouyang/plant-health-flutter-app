import 'package:flutter/material.dart';
import 'package:plant_health_data/shared/controllers/my_controllers.dart';
import 'package:plant_health_data/shared/enums/my_enums.dart';

class PlantNutritionDecisionTree {
  static List<String> classes = [
    "Nitrogen_Deficiency",
    "Nitrogen_Toxicity",
    "Water",
    "Phosphorus_Deficiency",
    "Potassium_Deficiency",
    "Magnesium_Deficiency",
    "Calcium_Deficiency",
    "Sulfur_Deficiency",
    "Iron_Deficiency",
    "Zinc_Deficiency",
    "Manganese_Deficiency",
    "Copper_Deficiency",
    "Boron_Deficiency",
    "Boron_Toxicity",
    "Molybdenum_Deficiency"
  ];

  static List<double> formatInput(Map<String, TextEditingController> percentageController, Map<String, BoolEditingController> boolController) {
    List<double> input = [];

    // percentageController.forEach(
    //   (key, ctl) {
    //     try {
    //       input.add(double.parse(ctl.text));
    //     } catch (e) {
    //       input.add(0.0);
    //       debugPrint("INPUT FORMATTING ERROR: $e");
    //     }
    //   },
    // );

    // boolController.forEach(
    //   (key, ctl) {
    //     try {
    //       input.add(double.parse(ctl.value.toString()));
    //     } catch (e) {
    //       input.add(0.0);
    //       debugPrint("INPUT FORMATTING ERROR: $e");
    //     }
    //   },
    // );

    input.add(double.parse(percentageController[PlantCharacteristics.youngLeavesChlorosis.value]!.text));
    input.add(double.parse(percentageController[PlantCharacteristics.oldLeavesChlorosis.value]!.text));

    input.add(boolController[PlantCharacteristics.entirePlantChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesEdgeChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.spotsChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesTipChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.completeInterveinalChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.partialInterveinalChlorosis.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesVeinChlorosis.value]!.getDoubleValue());

    input.add(boolController[PlantCharacteristics.deepGreenYoungLeaves.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.deepGreenOldLeaves.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.paleGreenLeaves.value]!.getDoubleValue());

    input.add(boolController[PlantCharacteristics.rollCurlingLeaves.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.flaccidLeaves.value]!.getDoubleValue());

    input.add(boolController[PlantCharacteristics.witchesBroom.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.dieback.value]!.getDoubleValue());

    input.add(boolController[PlantCharacteristics.leavesEdgeBrownAsh.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.spotsBrownAsh.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesTipBrownAsh.value]!.getDoubleValue());

    input.add(boolController[PlantCharacteristics.leavesEdgeRedPurple.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.spotsRedPurple.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesTipRedPurple.value]!.getDoubleValue());
    input.add(boolController[PlantCharacteristics.leavesVeinRedPurple.value]!.getDoubleValue());

    return input;
  }

  static String getClass(List<double> pred) {
    int index = pred.indexOf(1.0);
    return classes[index];
  }

  static List<double> predictNutrientDeficiency(List<double> input) {
    List<double> var0;
    if (input[14] <= 0.5) {
      if (input[1] <= 15.0) {
        if (input[17] <= 0.5) {
          if (input[0] <= 35.0) {
            if (input[11] <= 0.5) {
              if (input[21] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            } else {
              var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
            }
          } else {
            if (input[18] <= 0.5) {
              var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
            } else {
              if (input[5] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                if (input[4] <= 0.5) {
                  var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                } else {
                  var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                }
              }
            }
          }
        } else {
          if (input[18] <= 0.5) {
            if (input[0] <= 60.0) {
              if (input[5] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            } else {
              if (input[6] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            }
          } else {
            if (input[2] <= 0.5) {
              if (input[1] <= 8.5) {
                if (input[12] <= 0.5) {
                  if (input[0] <= 7.5) {
                    if (input[10] <= 0.5) {
                      var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                    } else {
                      var0 = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                    }
                  } else {
                    var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                  }
                } else {
                  if (input[4] <= 0.5) {
                    var0 = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                  } else {
                    var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
                  }
                }
              } else {
                if (input[0] <= 2.5) {
                  var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0];
                } else {
                  var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                }
              }
            } else {
              if (input[16] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            }
          }
        }
      } else {
        if (input[12] <= 0.5) {
          if (input[0] <= 57.5) {
            if (input[1] <= 47.5) {
              if (input[15] <= 0.5) {
                if (input[0] <= 5.0) {
                  var0 = [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                } else {
                  var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
                }
              } else {
                var0 = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            } else {
              var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0];
            }
          } else {
            var0 = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
          }
        } else {
          if (input[9] <= 0.5) {
            if (input[1] <= 35.0) {
              if (input[0] <= 10.0) {
                var0 = [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              }
            } else {
              var0 = [0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
            }
          } else {
            var0 = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
          }
        }
      }
    } else {
      if (input[3] <= 0.5) {
        var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0];
      } else {
        if (input[5] <= 0.5) {
          var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0];
        } else {
          if (input[17] <= 0.5) {
            var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
          } else {
            if (input[13] <= 0.5) {
              if (input[18] <= 0.5) {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0];
              } else {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
              }
            } else {
              if (input[0] <= 60.0) {
                if (input[16] <= 0.5) {
                  if (input[0] <= 40.0) {
                    if (input[18] <= 0.5) {
                      var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.0];
                    } else {
                      var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.0];
                    }
                  } else {
                    var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
                  }
                } else {
                  if (input[11] <= 0.5) {
                    var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0];
                  } else {
                    if (input[18] <= 0.5) {
                      if (input[1] <= 0.5) {
                        var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.0];
                      } else {
                        var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
                      }
                    } else {
                      if (input[1] <= 0.5) {
                        var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.0];
                      } else {
                        var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.0];
                      }
                    }
                  }
                }
              } else {
                var0 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0];
              }
            }
          }
        }
      }
    }
    return var0;
  }
}
