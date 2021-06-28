import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

class Object2D {
  String objectType = "Object2D";
  String sketchPlane = 'rootComp.xYConstructionPlane';
  Map<String, String> properties = Map();
  var object2DName = "Object2DName";

  void getNeededProperties() {
    throw Exception("This method is not implemented");
  }

  List toStringDisplay() {
    var neededProperties = this
        .properties
        .keys
        .where((elem) => this.properties[elem] == null)
        .toList();
    if (this.object2DName == "Object2DName") {
      throw Exception("This Object2D subclass needs a name");
    }

    // return this.objectType + ', '
    return neededProperties;
  }

  String toStringFusion() {
    return 'sketch = rootComp.sketches.add(${this.sketchPlane})\n';
  }

  void setProperty(propertyName, value) {
    if (!this.properties.containsKey(propertyName)) {
      throw Exception(
          '\'$propertyName\' is not a property of \'${this.object2DName}\'');
    }
  }

  String? getProperty(propertyName) {
    if (!this.properties.containsKey(propertyName)) {
      throw Exception(
          '\'$propertyName\' is not a property of \'${this.object2DName}\'');
    }
    return this.properties[propertyName].toString();
  }
}
