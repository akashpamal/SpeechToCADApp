import 'object_3d.dart';
import 'object_2d.dart';
import 'all_objects_2d.dart';

class Sphere extends PrimitiveObject3D {
  Sphere(radius) {
    this.objectType = "sphere";
    this.objectProperties["radius"] = radius;
    this.alternativeProperties['diameter'] = [
      "radius",
      (diameter) {
        return diameter / 2;
      }
    ];
  }

  String toStringFusion() {
    String part0 = super.toStringFusion();
    Circle circle = Circle(this.getProperty('radius'));
    String part1 = circle.toStringFusion();
    String part2;
    return "null";
  }
}

class Cube extends PrimitiveObject3D {
  Cube({sideLength}) {
    this.objectType = 'cube';
    this.objectProperties['side_length'] = sideLength.toString();
    this.alternativeProperties['length'] = [
      'side_length',
      (inputNum) {
        return inputNum;
      }
    ];
  }

  String toStringFusion() {
    String part0 = super.toStringFusion();
    var square = new Square(this.getProperty('side_length').toString());
    String part1 = square.toStringFusion();
    String part2 =
        "# DRAWING A CUBE\nextrude = rootComp.features.extrudeFeatures.addSimple(sketch.profiles[-1], adsk.core.ValueInput.createByReal(${this.getProperty('side_length').toString()}), adsk.fusion.FeatureOperations.NewBodyFeatureOperation)\n";
    return part0 + part1 + part2;
  }

  String toString() {
    return super.toString();
  }
}
