import 'package:flutter/material.dart';
import 'package:plant_health_data/shared/controllers/my_controllers.dart';

class MyCheckboxImage extends StatefulWidget {
  final String text;
  final String imageAsset;
  final BoolEditingController controller;

  const MyCheckboxImage({
    super.key,
    required this.text,
    required this.imageAsset,
    required this.controller,
  });

  @override
  State<MyCheckboxImage> createState() => _MyCheckboxImageState();
}

class _MyCheckboxImageState extends State<MyCheckboxImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onHover: (value) {},
        onTap: () {
          setState(() {
            widget.controller.setValue(state: !widget.controller.getValue());
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
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
                  height: MediaQuery.of(context).size.height * 0.25,
                  widget.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: widget.controller.getValue(),
                    onChanged: (value) => setState(() {
                      widget.controller.setValue(state: value);
                    }),
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                  Text(
                    widget.text,
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
