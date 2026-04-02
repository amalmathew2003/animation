import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class VideoFramePainter extends CustomPainter {
  final ui.Image image;
  VideoFramePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.width, size.height),
      image: image,
      fit: BoxFit.cover,
    );
  }

  @override
  bool shouldRepaint(VideoFramePainter oldDelegate) =>
      oldDelegate.image != image;
}