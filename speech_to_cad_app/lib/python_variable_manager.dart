import 'dart:io';

class PythonVariableManager {
  Set<String> globalVariables = Set<String>();

  void addGlobalVariable(String variableName) {
    this.globalVariables.add(variableName);
  }

  Set<String> getGlobalVariablesAsList() {
    return this.globalVariables;
  }

  String getGlobalVariablesAsString() {
    return 'global ' + this.globalVariables.join(', ') + ';\n';
  }
}
