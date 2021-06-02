import 'object_2d.dart';

class Square extends Object2D {
  Square(sideLength) {
    this.objectType = 'square';
    this.properties['sideLength'] = sideLength;
  }
  String toStringFusion() {
    var string1 = super.toStringFusion();
    var string2 = '        rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(\'${this.getProperty('sideLength')}\', \'${this.getProperty('sideLength')}\', 0))\n';
    return string1 + string2;
  }
}