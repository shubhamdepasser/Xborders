import 'package:flutter/material.dart';

class ImageItlscanner extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit boxFit;
  final Color color;

   ImageItlscanner({
   
      this.image,
     this.width,
     this.height,
     this.color,
    this.boxFit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: width,
      height: height,
      fit: boxFit,
      color: color,
      filterQuality: FilterQuality.high,
    );
  }
}
