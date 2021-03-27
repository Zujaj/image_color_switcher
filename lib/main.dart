import 'package:flutter/material.dart';
import 'package:image_color_switcher/widgets/color_slider.dart';
import 'package:image_color_switcher/widgets/image_color_switcher.dart';

void main() {
  runApp(MyApp());

  /// Hide the debug banner on the top right corner
  WidgetsApp.debugAllowBannerOverride = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Holds the Color value returned from [ColorSlider]
  Color colorCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Image Color Switcher',
        home: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
              child: ImageColorSwitcher(
            imagePath: 'assets/bike.png',
            color: colorCode ?? Colors.red,
          )),
          Expanded(
              child: ColorSlider(
            onColorSelected: (color) => setState(() => colorCode = color),
          )),
        ]))));
  }
}
