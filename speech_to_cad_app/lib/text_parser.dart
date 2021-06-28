import 'CAD Classes/all_objects_2d.dart';
import 'CAD Classes/all_objects_3d.dart';
import 'CAD Classes/object_2d.dart';
import 'CAD Classes/object_3d.dart';

class TextParser {
  Map? options;

  TextParser() {
    this.options = {
      () => new Cube(): ['cube', 'box']
    };

    var tempNewMap = Map();
    // print("TextParser constructor invoked");
    // print(this.options!.entries.toString());
    this.options!.forEach((key, value) {
      // print(value);
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
    // print('initializing possible properties list: ' +
    //     possibleProperties.join(', '));
    bool loaded = false;
    var property;
    var value;
    // print('allWords: ' + allWords.toString());
    allWords.sublist(startingIndex).forEach((word) {
      // print('word: ' + word.toString());
      // print('possible Properties: ' + possibleProperties.toString());
      // print('Word in possibleProperties: ' +
      //     possibleProperties.contains(word).toString());
      if (possibleProperties.contains(word)) {
        property = word;
        // print('Possible properties contained the word: ' + word.toString());
        if (loaded) {
          objectInProgress.setProperty(property, value);
          // print('Setting property for object: ' + property + ': ' + value);
          loaded = false;
          property = null;
          value = null;
        } else {
          loaded = true;
        }
      }
      try {
        // print('Attempting to extract int from word: ' + word.toString());
        value = int.parse(word); // TODO make this parse with a float
        // print('int successfully extracted');
        if (loaded) {
          // print('Attempting to set objct property');
          objectInProgress.setProperty(property, value);
          // print('Object property successfully set');
          // print('Setting property for object: ' + property + ': ' + value.toString());
          loaded = false;
          property = null;
          value = null;
        } else {
          loaded = true;
        }
      } on Exception catch (_) {
        // print('Exception triggered in main.dart');
        // print('Exceptrion triggered with word: ' + word.toString());
      }
      if (this.options!.containsKey(word)) {
        createdObjects.add(objectInProgress);
        // print('Creating new object');
        objectInProgress = this.options![word]();
        possibleProperties = objectInProgress.getPropertyList();
        loaded = false;
        property = null;
        value = null;
      }
    });
    createdObjects.add(objectInProgress);
    return createdObjects.sublist(1);
  }
}
