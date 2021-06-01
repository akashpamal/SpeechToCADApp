import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class Object2D {
  var objectType;
  var sketchPlane;
  var properties;

  Object2D() {
    this.sketchPlane = 'rootComp.xYConstructionPlane';
    this.properties = Map();
  }
}