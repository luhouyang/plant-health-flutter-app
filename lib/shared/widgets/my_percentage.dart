import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyPercentage extends StatefulWidget {
  final String hint;
  final String imageAsset;
  final TextEditingController controller;

  const MyPercentage({super.key, required this.hint, required this.imageAsset, required this.controller});

  @override
  State<MyPercentage> createState() => _MyPercentageState();
}

class _MyPercentageState extends State<MyPercentage> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                widget.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _key,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                controller: widget.controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a value!";
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  PercentageFormatter(),
                ],
                style: const TextStyle(color: Colors.green),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  suffix: const Text(
                    '%',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  focusColor: Colors.grey[400],
                  hintText: widget.hint,
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PercentageFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    try {
      if (double.parse(newValue.text) > 100.0) {
        return const TextEditingValue(text: "100.0");
      }
    } catch (e) {
      debugPrint("Formatted Error: $e");
    }
    return newValue;
  }
}
