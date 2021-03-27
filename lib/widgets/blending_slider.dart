import 'package:flutter/material.dart';

// A Custom Slider to select different blending modes.
class BlendingSlider extends StatelessWidget {
  /// Holds the blending modes
  final List<BlendMode> _blendModes = BlendMode.values;

  /// Triggers when tapped on a blendMode.
  /// Returns an enum blendmode value on tap.
  final Function(BlendMode) onBlendModeSelected;

  BlendingSlider({@required this.onBlendModeSelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        ..._blendModes
            .asMap()
            .entries
            .map((MapEntry<int, BlendMode> blendMode) {
          return InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: () => onBlendModeSelected(blendMode.value),
            child: Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text(
                        blendMode.value.toString().split('.')[1].toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8.75,
                            fontWeight: FontWeight.bold)))),
          );
        })
      ],
    );
  }
}
