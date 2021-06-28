import 'object_2d.dart';

class Rectangle extends Object2D {
  Rectangle(width, height) {
    this.objectType = "rectangle";
    this.properties['width'] = width;
    this.properties['height'] = height;
  }

  String toStringFusion() {
    String returnString = super.toStringFusion();
    returnString +=
        "rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(${this.getProperty('width')}, ${this.getProperty('height')}, 0))\n";
    return returnString;
  }
}

class Square extends Object2D {
  Square(sideLength) {
    this.objectType = 'square';
    this.properties['sideLength'] = sideLength;
  }

  String toStringFusion() {
    var string1 = super.toStringFusion();
    var string2 =
        'rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(${this.getProperty('sideLength')}, ${this.getProperty('sideLength')}, 0))\n';
    return string1 + string2;
  }
}

class Circle extends Object2D {
  Circle(radius) {
    this.objectType = "circle";
    this.properties['radius'] = radius;
  }

  String toStringFusion() {
    String returnString = super.toStringFusion();
    returnString +=
        "circles = sketch.sketchCurves.sketchCircles.addByCenterRadius(adsk.core.Point3D.create(0, 0, 0), ${this.getProperty('radius')})\n";
    return returnString;
  }
}
