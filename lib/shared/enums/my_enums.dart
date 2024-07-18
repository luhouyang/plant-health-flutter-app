enum PlantCharacteristics {
  // chlorosis
  youngLeavesChlorosis("youngLeavesChlorosis"),
  oldLeavesChlorosis("oldLeavesChlorosis"),
  entirePlantChlorosis("entirePlantChlorosis"),
  leavesEdgeChlorosis("leavesEdgeChlorosis"),
  spotsChlorosis("spotsChlorosis"),
  leavesTipChlorosis("leavesTipChlorosis"),
  completeInterveinalChlorosis("completeInterveinalChlorosis"),
  partialInterveinalChlorosis("partialInterveinalChlorosis"),
  leavesVeinChlorosis("leavesVeinChlorosis"),

  // dark/pale green
  deepGreenYoungLeaves(" deepGreenYoungLeaves"),
  deepGreenOldLeaves("deepGreenOldLeaves"),
  paleGreenLeaves("paleGreenLeaves"),

  // leaf structure
  rollCurlingLeaves("rollCurlingLeaves"),
  flaccidLeaves("flaccidLeaves"),

  // growth
  witchesBroom("witchesBroom"),
  dieback("dieback"),

  // brown/ash colour
  leavesEdgeBrownAsh("leavesEdgeBrownAsh"),
  spotsBrownAsh("spotsBrownAsh"),
  leavesTipBrownAsh("leavesTipBrownAsh"),

  // red/purple colour
  leavesEdgeRedPurple("leavesEdgeRedPurple"),
  spotsRedPurple("spotsRedPurple"),
  leavesTipRedPurple("leavesTipRedPurple"),
  leavesVeinRedPurple("leavesVeinRedPurple");

  final String value;
  const PlantCharacteristics(this.value);
}
