import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as External;

class ImageColorSwitcher extends StatefulWidget {
  /// Holds the Image Path
  final String imagePath;

  /// Holds the MaterialColor
  final MaterialColor color;

  ImageColorSwitcher({this.imagePath, this.color});

  @override
  _ImageColorSwitcherState createState() => _ImageColorSwitcherState();
}

class _ImageColorSwitcherState extends State<ImageColorSwitcher> {
  /// Holds the Image in Byte Format
  Uint8List imageBytes;

  @override
  void initState() {
    rootBundle.load(widget.imagePath).then(
        (data) => setState(() => this.imageBytes = data.buffer.asUint8List()));

    super.initState();
  }

  /// A function that switches the image Color.
  Future<Uint8List> switchColor(Uint8List bytes) async {
    // Decode the bytes to [Image] type
    final image = External.decodeImage(bytes);

    // Convert the [Image] to RGBA formatted pixels
    final pixels = image.getBytes(format: External.Format.rgba);

    // Get the Pixel Length
    final int length = pixels.lengthInBytes;

    for (var i = 0; i < length; i += 4) {
      ///           PIXELS
      /// =============================
      /// | i | i + 1 | i + 2 | i + 3 |
      /// =============================

      // pixels[i] represents Red
      // pixels[i + 1] represents Green
      // pixels[i + 2] represents Blue
      // pixels[i + 3] represents Alpha

      // Detect the light blue color & switch it with the desired color's RGB value.
      if (pixels[i] == 189 && pixels[i + 1] == 212 && pixels[i + 2] == 222) {
        pixels[i] = widget.color.shade300.red;
        pixels[i + 1] = widget.color.shade300.green;
        pixels[i + 2] = widget.color.shade300.blue;
      }
      // Detect the darkish blue shade & switch it with the desired color's RGB value.
      else if (pixels[i] == 63 && pixels[i + 1] == 87 && pixels[i + 2] == 101) {
        pixels[i] = widget.color.shade900.red;
        pixels[i + 1] = widget.color.shade900.green;
        pixels[i + 2] = widget.color.shade900.blue;
      }
    }
    return External.encodePng(image);
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes == null
        ? Center(child: CircularProgressIndicator())
        : FutureBuilder(
            future: switchColor(imageBytes),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              return snapshot.hasData
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.memory(
                        snapshot.data,
                      ).image)),
                    )
                  : CircularProgressIndicator();
            },
          );
  }
}
