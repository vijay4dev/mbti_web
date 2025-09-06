import 'package:flutter/material.dart';

class ZigZagClipper extends CustomClipper<Path> {
  final double zigzagHeight;
  final double zigzagWidth;

  ZigZagClipper({this.zigzagHeight = 10, this.zigzagWidth = 10});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.moveTo(0, 0);

    // Top zigzag
    for (double i = 0; i < size.width; i += zigzagWidth) {
      path.lineTo(i + zigzagWidth / 2, zigzagHeight);
      path.lineTo(i + zigzagWidth, 0);
    }

    // Right side
    path.lineTo(size.width, size.height);

    // Bottom zigzag
    for (double i = size.width; i > 0; i -= zigzagWidth) {
      path.lineTo(i - zigzagWidth / 2, size.height - zigzagHeight);
      path.lineTo(i - zigzagWidth, size.height);
    }

    // Left side
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(ZigZagClipper oldClipper) => false;
}
