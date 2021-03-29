import 'package:flutter/material.dart';
import 'package:image_color_switcher/widgets/blending_slider.dart';
import 'package:image_color_switcher/widgets/bike_painter.dart';
import 'package:image_color_switcher/widgets/color_slider.dart';
import 'package:image_color_switcher/widgets/image_color_switcher.dart';
import 'package:image_color_switcher/widgets/svg_color_slider.dart';

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
  // Holds the BlendMode returned from [BlendingSlider]
  BlendMode blendMode;

  // Holds the encoded color string value returned from [SVGColorSlider]
  String svgColorCode = '';

  // Holds the Color value returned from [ColorSlider]
  Color colorCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Color Switcher',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Blending Slider',
                ),
                Tab(
                  text: 'Raster',
                ),
                Tab(
                  text: 'Vector',
                ),
              ],
            ),
            title: Text('Image Color Switcher Demo'),
          ),
          body: TabBarView(
            children: [
              // BLENDING SLIDER
              Column(children: [
                Expanded(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.red, blendMode ?? BlendMode.clear),
                    child: Image.asset('assets/bike.png'),
                  ),
                ),
                Expanded(
                  child: BlendingSlider(
                    onBlendModeSelected: (value) =>
                        setState(() => blendMode = value),
                  ),
                )
              ]),
              // RASTER TAB
              Column(children: [
                Expanded(
                    child: ImageColorSwitcher(
                  imagePath: 'assets/bike.png',
                  color: colorCode ?? Colors.red,
                )),
                Expanded(
                    child: ColorSlider(
                  onColorSelected: (color) => setState(() => colorCode = color),
                ))
              ]),
              // VECTOR TAB
              Column(children: [
                Expanded(
                    child: Transform.scale(
                        scale: 25,
                        alignment: Alignment.center,
                        child: Container(
                          width: 10,
                          height: 10,
                          child: BikePainter(
                              color: svgColorCode.isNotEmpty
                                  ? svgColorCode.split('.')[1].split(':')[0]
                                  : '#bdd4de',
                              shade: svgColorCode.isNotEmpty
                                  ? svgColorCode.split('.')[1].split(':')[1]
                                  : '#3f5765'),
                        ))),
                Expanded(
                    child: SVGColorSlider(
                  onColorSelected: (color) =>
                      setState(() => svgColorCode = color),
                )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
