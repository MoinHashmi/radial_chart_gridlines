import 'package:flutter/material.dart';

class CustomDashedLine extends CustomPainter{

  final double meanLineWidth;
  final Color color;

  CustomDashedLine({
    this.meanLineWidth=1,
    this.color=const Color(0xFF00B6E6)
  });

  @override
  void paint(Canvas canvas, Size size) {

    var width=size.width;
    var height=size.height;
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width / 2;



    var paint2 = Paint()
      ..color = color
      ..strokeWidth = meanLineWidth
      ..style = PaintingStyle.fill;


    for(double i = 0; i < centerY; i = i + 15){
      if(i% 3 == 0)
        canvas.drawLine(Offset(centerX, i), Offset(centerX, i+10), paint2);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}