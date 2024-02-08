import 'dart:ui';

import 'package:flutter/material.dart';

class ShaderPainter extends CustomPainter {
  late final Paint _paint;
  final FragmentShader shader;
  ShaderPainter({
    required this.shader,
    super.repaint,
  }) {
    _paint = Paint()..shader = shader;
  }

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);

    canvas.drawRect(Offset.zero & size, _paint);
  }

  @override
  bool shouldRepaint(ShaderPainter oldDelegate) => false;
}
