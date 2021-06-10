class PrimitiveObject3D {
  var objectType;
  var objectProperties;
  var sketchProfiles;
  var alternativeProperties;

  PrimitiveObject3D() {
    this.objectType = 'Primitive Object3D';
    this.objectProperties = Map();
    this.sketchProfiles = [];
    this.alternativeProperties = [];
  }

  void getNeededProperties() {
    throw Exception("This method is not implemented");
  }

  void toStringDisplay() {
      throw Exception("This method is not implemented");
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
      this.objectProperties[objectProperty] = adjustmentFunction[value];
      return;
    }
    throw Exception("\'$propertyName\' is not a property of \'${this.objectType}\'");
  }

  String getProperty(propertyName) {
    if (!this.objectProperties.containsKey(propertyName)) {
      throw Exception("\'$propertyName\' is not a property of \'${this.objectType}\'");
    }
    return this.objectProperties[propertyName];
  }

  List getPropertyList() {
    return new List.from(this.objectProperties.keys)..addAll(this.alternativeProperties.keys);
  }
}