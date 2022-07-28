import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomRadialChart extends CustomPainter{

  // const CustomRadialChart();

  final Color gridColor;
  final Color viewPortBorderColor;
  final TextStyle labelStyle;

  CustomRadialChart({
    this.gridColor=const Color(0xff000000),
    this.viewPortBorderColor=const Color(0xff000000),
    this.labelStyle=const TextStyle(
        color: Color(0xff000000),
        fontSize: 14
    ),
  });

  @override
  void paint(Canvas canvas, Size size) {
    const offset20=20;
    const maxVal=100;
    const numberOfLables=5;
    var width=size.width-offset20;
    var height=size.height-offset20;
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width / 2;

    var paint1 = Paint()
      ..color = gridColor
      ..strokeWidth = 0.6
      ..style = PaintingStyle.fill;

    var axisLinePaint = Paint()
      ..color = viewPortBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth=1;

    var dataLinePaint = Paint()
      ..color = Color(0xff000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth=12;


    // canvas.drawCircle(Offset(centerX, centerY), radius, paint1);
    canvas.drawArc(Rect.fromLTRB(0, 0, width, height),
        getRadiansByAngle(-90), getRadiansByAngle(270), true, axisLinePaint);

    int gap=270~/numberOfLables;

    print('GAP: $gap');

    int label=0;

    final TextPainter textPainter0 = TextPainter(
        text: TextSpan(text: '0', style: labelStyle),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr
    )
      ..layout(maxWidth: width);

    textPainter0.paint(canvas, Offset(radius-4, -20));

    //Creating gridlines

    for (var i = gap; i <= 270; i += gap) {
      var myThetaAngle = 0;
      label=label+(maxVal~/numberOfLables);

      if (i <= 90) {
        myThetaAngle = 270 + i;
      } else {
        myThetaAngle = i - 90;
      }

      var theta = myThetaAngle * (pi / 180);
      var offSet=Offset(centerX + radius * cos(theta), centerY + radius * sin(theta));

      canvas.drawLine(
          offSet,
          Offset(centerX, centerY),
          paint1);

      var labelText=getFormattedLabel(label);



      final TextPainter textPainter = TextPainter(
          text: TextSpan(text: '$labelText', style: labelStyle),
          textAlign: TextAlign.justify,
          textDirection: TextDirection.ltr
      )
        ..layout(maxWidth: width);

      print('THETA: $theta ANGLE: $labelText');


      if(theta<=1.0){
        textPainter.paint(canvas, Offset(offSet.dx+4, offSet.dy-4));
      }else if(theta <= 1.570){
        textPainter.paint(canvas, Offset(offSet.dx-4, offSet.dy+2));
      }else if(theta <= 3.064){
        if(labelText.length>3) {
          textPainter.paint(canvas, Offset(offSet.dx-34, offSet.dy+2));
        }else if(labelText.length>2) {
          textPainter.paint(canvas, Offset(offSet.dx-28, offSet.dy+2));
        }else{
          textPainter.paint(canvas, Offset(offSet.dx-14, offSet.dy+2));
        }
      }else if(theta <= 4.596){
        if(labelText.length>3) {
          textPainter.paint(canvas, Offset(offSet.dx-34, offSet.dy+2));
        }else if(labelText.length>2) {
          textPainter.paint(canvas, Offset(offSet.dx-30, offSet.dy-8));
        }else{
          textPainter.paint(canvas, Offset(offSet.dx-14, offSet.dy+2));
        }
      }else if(theta <= 6.29){
        textPainter.paint(canvas, Offset(offSet.dx+4, offSet.dy-16));
      }else{
        if(labelText.length>3) {
          textPainter.paint(canvas, Offset(offSet.dx - 36, offSet.dy - 8));
        }else if(labelText.length>2) {
          textPainter.paint(canvas, Offset(offSet.dx-28, offSet.dy+2));
        }else{
          textPainter.paint(canvas, Offset(offSet.dx - 22, offSet.dy - 8));
        }
      }

    }

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        height: height-32,
        width: width-32,
      ),
      pi*1.5,
      pi*1.5*0.87,
      false,
      dataLinePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        height: height-64,
        width: width-64,
      ),
      pi*1.5,
      pi*1.5,
      false,
      axisLinePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        height: height-96,
        width: width-96,
      ),
      pi*1.5,
      pi*1.5*0.68,
      false,
      dataLinePaint,
    );

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        height: height-128,
        width: width-128,
      ),
      pi*1.5,
      pi*1.5,
      false,
      axisLinePaint,
    );


    var thetaCalculateValue = (70 / maxVal) * 270; // here 61 is user specified value in the range // it can be any

    if (thetaCalculateValue <= 90) {

      thetaCalculateValue = 270 + thetaCalculateValue;

    } else {

      thetaCalculateValue = thetaCalculateValue - 90;

    }

    thetaCalculateValue = getRadiansByAngle(thetaCalculateValue);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}

double getRadiansByAngle(double angle) {
  return (angle * pi / 180);
}

getFormattedLabel(int label){
  if(label>=1000000){
    return '${label~/1000000}M';
  }else if(label>100000 && label<=1000000){
    return '${label~/1000}K';
  }else if(label>10000 && label<=100000){
    return '${label~/1000}K';
  }else if(label>1000 && label<=10000){
    return '${label~/1000}K';
  }else{
    return '$label';
  }
}