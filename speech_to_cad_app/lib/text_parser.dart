import 'CAD Classes/all_objects_2d.dart';
import 'CAD Classes/all_objects_3d.dart';
import 'CAD Classes/object_2d.dart';
import 'CAD Classes/object_3d.dart';

class TextParser {
  Map? options;

  TextParser() {
    this.options = {
      () => new Cube(5): ['cube', 'box']
    };

    var tempNewMap = Map();
    // print("TextParser constructor invoked");
    print(this.options!.entries.toString());
    this.options!.forEach((key, value) {
      print(value);
      value.forEach((element) {
        tempNewMap[element] = key;
      });
    });

    // print(tempNewMap);
    // print(tempNewMap['cube'].runtimeType);

    this.options = tempNewMap;
  }

  List<String> _preProcessText(String rawText) {
    List<String> preProcessedText = rawText.split(" ");
    preProcessedText = preProcessedText
        .map((elem) => elem.toLowerCase().replaceAll('.', ''))
        .toList();
    return preProcessedText;
  }

  List textToObjects(rawText) {
    List<String> allWords = this._preProcessText(rawText);
    var createdObjects = [];
    int startingIndex = allWords.indexOf(allWords
        .where((element) => this.options!.containsKey(element))
        .toList()[0]);

    PrimitiveObject3D objectInProgress =
        this.options![allWords[startingIndex]]();
    List<String> possibleProperties = objectInProgress.getPropertyList();
    bool loaded = false;
    var property = null;
    var value = null;
    allWords.sublist(startingIndex).forEach(
      (word) {
        if (possibleProperties.contains(word)) {
          property = word;
          if (loaded) {
            objectInProgress.setProperty(property, value);
            loaded = false;
            property = null;
            value = null;
          } else {
            loaded = true;
          }
        }
        try {
          value = int.parse(word);
          if (loaded) {
            objectInProgress.setProperty(property, value);
            loaded = false;
            property = null;
            value = null;
          } else {
            loaded = true;
          }
        } on Exception catch (_) {}
        if (this.options!.containsKey(word)) {
          createdObjects.add(objectInProgress);
          objectInProgress = this.options![word]();
          possibleProperties = objectInProgress.getPropertyList();
          loaded = false;
          property = null;
          value = null;
        }
      }
    );
    createdObjects.add(objectInProgress);
    return createdObjects.sublist(1);
  }

}
