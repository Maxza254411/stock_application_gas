import 'package:flutter/material.dart';

class Watermark extends StatelessWidget {
  final ImageProvider backgroundImage;
  final Widget child;

  const Watermark({
    required this.backgroundImage,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: backgroundImage, opacity: 0.2),
          ),
        ),
        child,
      ],
    );
  }
}
