import 'package:flutter/material.dart';

import 'custom_dashed_line.dart';
import 'custom_radial_chart.dart';

class CircularRadialChart extends StatelessWidget {

  final double meanLineWidth;
  final Color meanLineColor;
  final Color gridColor;
  final Color viewPortBorderColor;
  final TextStyle labelStyle;
  double? chartSize;

  CircularRadialChart({
    Key? key,
    this.gridColor=const Color(0xff000000),
    this.viewPortBorderColor=const Color(0xff000000),
    this.labelStyle=const TextStyle(
        color: Color(0xff000000),
        fontSize: 14
    ),
    this.meanLineWidth=1,
    this.meanLineColor=const Color(0xFF00B6E6),
    this.chartSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(chartSize==null){
      chartSize=MediaQuery.of(context).size.width*0.75;
    }

    return Center(
      child: UnconstrainedBox(
        child: Stack(
          children: [

            Container(
              // color: Colors.yellow,
              width: chartSize,
              height: chartSize,
              child: CustomPaint(
                painter: CustomRadialChart(
                  gridColor: gridColor,
                  viewPortBorderColor: viewPortBorderColor,
                  labelStyle: labelStyle,
                ),
              ),
            ),

            Transform.rotate(
              angle: 2.5,
              alignment: Alignment.center,
              child: Container(
                height: chartSize! - 20,
                width: chartSize! - 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle
                ),
                child: CustomPaint(
                  painter: CustomDashedLine(
                    meanLineWidth: meanLineWidth,
                    color: meanLineColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
