import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class Object2D {
  var objectType;
  var sketchPlane;
  var properties;
  var object2DName;

  Object2D() {
    this.sketchPlane = 'rootComp.xYConstructionPlane';
    this.properties = Map();
  }

  void getNeededProperties() {
    throw Exception("This method is not implemented");
  }

  List toStringDisplay() {
    var neededProperties = this
        .properties
        .keys
        .where((elem) => this.properties[elem] == null)
        .toList();
    if (this.object2DName == null) {
      throw Exception("This Object2D subclass needs a name");
    }
    if (this.sketchPlane == null) {
      neededProperties.add('surface');
    }
    // return this.objectType + ', '
    return neededProperties;
  }

  String toStringFusion() {
    throw Exception("This method is not implemented");
  }

  void setProperty(propertyName, value) {
    if (!this.properties.containsKey(propertyName)) {
      throw Exception('\'$propertyName\' is not a property of {self.object_2d_name}');
    }
  }
  
  String? getProperty(propertyName) {
    if (!this.properties.containsKey(propertyName)) {
      throw Exception('\'$propertyName\' is not a property of {self.object_2d_name}');
    }
  }
}
