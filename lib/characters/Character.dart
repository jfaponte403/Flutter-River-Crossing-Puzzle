import 'package:flutter/material.dart';

class Character extends StatelessWidget {
  final String imagePath;
  final double? maxWidth;
  final String name;

  const Character({Key? key, required this.imagePath, required this.name, this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: maxWidth != null
          ? Image.asset(
        imagePath,
        width: maxWidth,
        fit: BoxFit.scaleDown,
      )
          : Image.asset(
        imagePath,
      ),
    );
  }
}
