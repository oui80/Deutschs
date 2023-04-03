import 'package:Dutch/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget myContainer(Widget contenue) {
  return Neumorphic(
    style: NeumorphicStyle(
      intensity: 0.8,
      surfaceIntensity: 0.04,
      depth: 4,
      shape: NeumorphicShape.concave,
      color: mygrey,
    ),
    child: Container(
      color: myWhite,
      child: contenue,
    ),
  );
}