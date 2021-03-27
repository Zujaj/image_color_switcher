import 'package:flutter/material.dart';

/// A Custom Slider that returns a selected color.

class ColorSlider extends StatelessWidget {
  /// Map holding the color name with its value
  final Map<String, Color> _colorMap = {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Light Blue': Colors.lightBlue,
    'Blue Grey': Colors.blueGrey,
    'Brown': Colors.brown,
    'Cyan': Colors.cyan,
    'Purple': Colors.purple,
    'Deep Purple': Colors.deepPurple,
    'Light Green': Colors.lightGreen,
    'Indigo': Colors.indigo,
    'Amber': Colors.amber,
    'Yellow': Colors.yellow,
    'Lime': Colors.lime,
    'Orange': Colors.orange,
    'Dark Orange': Colors.deepOrange,
    'Teal': Colors.teal,
    'Pink': Colors.pink,
    'Black': MaterialColor(
      Colors.black.value,
      {
        50: Colors.black38,
        100: Colors.black38,
        200: Colors.black38,
        300: Colors.grey.shade800,
        400: Colors.black38,
        500: Colors.black38,
        600: Colors.black38,
        700: Colors.black38,
        800: Colors.black38,
        900: Colors.black,
      },
    ),
    'White': MaterialColor(
      Colors.white.value,
      {
        50: Colors.white,
        100: Colors.white,
        200: Colors.white,
        300: Colors.white,
        400: Colors.white,
        500: Colors.white,
        600: Colors.white,
        700: Colors.white,
        800: Colors.white,
        900: Colors.grey.shade700,
      },
    ),
    'Grey': Colors.grey,
  };

  /// Triggers when tapped on a color
  final Function(Color) onColorSelected;

  ColorSlider({@required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ..._colorMap.entries.map((MapEntry<String, Color> colorEntry) {
          return InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: () => onColorSelected(colorEntry.value),
            child: Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: colorEntry.value,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorEntry.value.withOpacity(0.8),
                      offset: Offset(1.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Center(
                    child:
                        // If the color is Black, change font color to white
                        colorEntry.key == 'Black'
                            ? Text(colorEntry.key.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 8.75,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                            : Text(colorEntry.key.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 8.75,
                                    fontWeight: FontWeight.bold)))),
          );
        })
      ],
    );
  }
}
