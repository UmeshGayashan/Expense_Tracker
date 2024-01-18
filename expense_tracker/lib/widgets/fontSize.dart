import 'package:flutter/material.dart';

class FontSizeChanger extends StatefulWidget {
  @override
  _FontSizeChangerState createState() => _FontSizeChangerState();
}

class _FontSizeChangerState extends State<FontSizeChanger> {
  double fontSize = 16.0; // Default font size

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Change Font Size'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Slider(
                value: fontSize,
                min: 10.0,
                max: 30.0,
                onChanged: (value) {
                  setState(() {
                    fontSize = value;
                  });
                },
              ),
              Text('Selected Font Size: ${fontSize.toStringAsFixed(1)}'),
              ElevatedButton(
                onPressed: () {
                  // Apply the selected font size and close the dialog
                  // You can implement your logic to apply the font size here
                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
