class PrimitiveObject3D {
  var objectType;
  var objectProperties;
  var sketchProfiles;
  var alternativeProperties;

  PrimitiveObject3D() {
    this.objectType = 'Primitive Object3D';
    this.objectProperties = Map();
    this.sketchProfiles = [];
    this.alternativeProperties = Map();
  }

  void getNeededProperties() {
    throw Exception("This method is not implemented");
  }

  String toString() {
    List<String> attributesList = [];
    this.objectProperties.forEach((key, value) {
      attributesList.add(key + ': ' + value.toString());
    });
    String returnString = this.objectType.toString() +
        this.objectType.substring(1).toLowerCase() +
        '||' +
        attributesList.join(', ');
    return returnString;
  }

  String toStringFusion() {
    return "";
  }

  void setProperty(propertyName, value) {
    if (this.objectProperties.containsKey(propertyName)) {
      this.objectProperties[propertyName] = value;
      return;
    }

    if (this.alternativeProperties.containsKey(propertyName)) {
      var objectProperty = this.alternativeProperties[propertyName][0];

      var adjustmentFunction = this.alternativeProperties[propertyName][1];
      // print('')
      this.objectProperties[objectProperty] = adjustmentFunction(value);
      return;
    }

    throw Exception(
        "\'$propertyName\' is not a property of \'${this.objectType}\'");
  }

  String getProperty(propertyName) {
    if (!this.objectProperties.containsKey(propertyName)) {
      throw Exception(
          "\'$propertyName\' is not a property of \'${this.objectType}\'");
    }
    return this.objectProperties[propertyName].toString();
  }

  List<String> getPropertyList() {
    // print('ObjectProperties keys:');
    // List.from(this.objectProperties.keys);
    // print(this.objectProperties.keys.runtimeType);
    // print('alternativeProperties keys:');
    // print(this.alternativeProperties.keys.runtimeType);
    return new List.from(this.objectProperties.keys)
      ..addAll(List.from(this.alternativeProperties.keys));
  }
}
