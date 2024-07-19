import 'package:flutter/material.dart';

class BoolEditingController extends ChangeNotifier {
  bool value = false;

  void setValue({required bool? state}) {
    value = state ?? false;
    notifyListeners();
  }

  bool getValue() {
    return value;
  }

  double getDoubleValue() {
    return value ? 1.0 : 0.0;
  }
}
