// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool _hasSpeech = false;
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = '';
//   String lastError = '';
//   String lastStatus = '';
//   String _currentLocaleId = '';
//   int resultListened = 0;
//   List<LocaleName> _localeNames = [];
//   final SpeechToText speech = SpeechToText();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Future<void> initSpeechState() async {
//     var hasSpeech = await speech.initialize(
//         onError: errorListener,
//         onStatus: statusListener,
//         debugLogging: true,
//         finalTimeout: Duration(milliseconds: 0));
//     if (hasSpeech) {
//       _localeNames = await speech.locales();
//
//       var systemLocale = await speech.systemLocale();
//       _currentLocaleId = systemLocale?.localeId ?? '';
//     }
//
//     if (!mounted) return;
//
//     setState(() {
//       _hasSpeech = hasSpeech;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Speech to Text Example'),
//         ),
//         body: Column(children: [
//           Center(
//             child: Text(
//               'Speech recognition available',
//               style: TextStyle(fontSize: 22.0),
//             ),
//           ),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     TextButton(
//                       onPressed: _hasSpeech ? null : initSpeechState,
//                       child: Text('Initialize'),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     TextButton(
//                       onPressed: !_hasSpeech || speech.isListening
//                           ? null
//                           : startListening,
//                       child: Text('Start'),
//                     ),
//                     TextButton(
//                       onPressed: speech.isListening ? stopListening : null,
//                       child: Text('Stop'),
//                     ),
//                     TextButton(
//                       onPressed: speech.isListening ? cancelListening : null,
//                       child: Text('Cancel'),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     DropdownButton(
//                       onChanged: (selectedVal) => _switchLang(selectedVal),
//                       value: _currentLocaleId,
//                       items: _localeNames
//                           .map(
//                             (localeName) => DropdownMenuItem(
//                           value: localeName.localeId,
//                           child: Text(localeName.name),
//                         ),
//                       )
//                           .toList(),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Column(
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     'Recognized Words',
//                     style: TextStyle(fontSize: 22.0),
//                   ),
//                 ),
//                 Expanded(
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         color: Theme.of(context).selectedRowColor,
//                         child: Center(
//                           child: Text(
//                             lastWords,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Positioned.fill(
//                         bottom: 10,
//                         child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Container(
//                             width: 40,
//                             height: 40,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     blurRadius: .26,
//                                     spreadRadius: level * 1.5,
//                                     color: Colors.black.withOpacity(.05))
//                               ],
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(50)),
//                             ),
//                             child: IconButton(
//                               icon: Icon(Icons.mic),
//                               onPressed: () => null,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Column(
//               children: <Widget>[
//                 Center(
//                   child: Text(
//                     'Error Status',
//                     style: TextStyle(fontSize: 22.0),
//                   ),
//                 ),
//                 Center(
//                   child: Text(lastError),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             color: Theme.of(context).backgroundColor,
//             child: Center(
//               child: speech.isListening
//                   ? Text(
//                 "I'm listening...",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )
//                   : Text(
//                 'Not listening',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   void startListening() {
//     lastWords = '';
//     lastError = '';
//     speech.listen(
//         onResult: resultListener,
//         listenFor: Duration(seconds: 30),
//         pauseFor: Duration(seconds: 5),
//         partialResults: true,
//         localeId: _currentLocaleId,
//         onSoundLevelChange: soundLevelListener,
//         cancelOnError: true,
//         listenMode: ListenMode.confirmation);
//     setState(() {});
//   }
//
//   void stopListening() {
//     speech.stop();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   void cancelListening() {
//     speech.cancel();
//     setState(() {
//       level = 0.0;
//     });
//   }
//
//   void resultListener(SpeechRecognitionResult result) {
//     ++resultListened;
//     print('Result listener $resultListened');
//     setState(() {
//       lastWords = '${result.recognizedWords} - ${result.finalResult}';
//     });
//   }
//
//   void soundLevelListener(double level) {
//     minSoundLevel = min(minSoundLevel, level);
//     maxSoundLevel = max(maxSoundLevel, level);
//     // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
//     setState(() {
//       this.level = level;
//     });
//   }
//
//   void errorListener(SpeechRecognitionError error) {
//     // print("Received error status: $error, listening: ${speech.isListening}");
//     setState(() {
//       lastError = '${error.errorMsg} - ${error.permanent}';
//     });
//   }
//
//   void statusListener(String status) {
//     // print(
//     // 'Received listener status: $status, listening: ${speech.isListening}');
//     setState(() {
//       lastStatus = '$status';
//     });
//   }
//
//   void _switchLang(selectedVal) {
//     setState(() {
//       _currentLocaleId = selectedVal;
//     });
//     print(selectedVal);
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'CAD Classes/all_objects_2d.dart';
import 'CAD Classes/all_objects_3d.dart';
import 'text_parser.dart';

import 'package:speech_to_cad_app/communication_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  CommunicationManagerClient communicationManager =
      CommunicationManagerClient();

  // print("Creating text parser");

  TextParser textParser = TextParser();

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SpeechToCAD"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                communicationManager.createNewDocument();
              },
              child: Text("Create New Document"),
            ),
            TextButton(
              onPressed: () async {
                // await communicationManager.sendMessage("");
                // await Future.delayed(Duration(seconds: 2));
                communicationManager.addGlobalVariable('sketch');
                bool completedSuccesfully = await communicationManager.sendMessage(
                    "global sketch;sketch = rootComp.sketches.add(rootComp.xYConstructionPlane)");
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("Start Sketch"),
            ),
            TextButton(
              onPressed: () async {
                // await communicationManager.sendMessage("");
                communicationManager.addGlobalVariable('rec1');
                bool completedSuccesfully = await communicationManager.sendMessage(
                    "rec1 = sketch.sketchCurves.sketchLines.addTwoPointRectangle(adsk.core.Point3D.create(0, 0, 0), adsk.core.Point3D.create(20, 20, 0))");
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("Square Sketch"),
            ),
            TextButton(
              onPressed: () async {
                // await communicationManager.sendMessage("");
                communicationManager.addGlobalVariable('extrude');
                bool completedSuccesfully = await communicationManager.sendMessage(
                    "extrude = rootComp.features.extrudeFeatures.addSimple(sketch.profiles[-1], adsk.core.ValueInput.createByReal(20), adsk.fusion.FeatureOperations.NewBodyFeatureOperation)");
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("Cube Extrusion"),
            ),
            TextButton(
              onPressed: () async {
                bool completedSuccesfully =
                    await communicationManager.refreshView();
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("Refresh screen"),
            ),
            TextButton(
              onPressed: () async {
                // var mySquare = Square(5);
                // print('Side length of mySquare: ' +
                //     mySquare.properties['sideLength'].toString());
                communicationManager.addGlobalVariable('sketch');
                communicationManager.addGlobalVariable('rec1');
                communicationManager.addGlobalVariable('extrude');
                var myCube = Cube(sideLength: 5);
                print('Cube toStringFusion:' + myCube.toStringFusion());
                bool completedSuccesfully = await communicationManager
                    .sendMessage(myCube.toStringFusion());
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("Make cube with object"),
            ),
            TextButton(
              onPressed: () async {
                bool completedSuccesfully =
                    await communicationManager.sendMessage("exit()");
                showFusionUnavailableIfNecessary(context, completedSuccesfully);
              },
              child: Text("exit()"),
            ),
            TextButton(
                onPressed: () {
                  textParserTest();
                },
                child: Text("Test TextParser")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          communicationManager.refreshView();
        },
        child: Icon(Icons.build),
      ),
    );
  }

  void showFusionUnavailableIfNecessary(
      var context, bool completedSuccessfully) {
    if (!completedSuccessfully) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Text(
              "Fusion360 unavailable",
              textAlign: TextAlign.center,
            ),
            content: const Text(
              "Please run FusionScriptRunner from Fusion360 and try again",
              textAlign: TextAlign.center,
            )
            // content: const Text("AlertDialog Description"),
            ),
      );
    }
  }

  void textParserTest() {
    // print('new test for textparser');
    TextParser textParser = TextParser();
    var allObjects =
        textParser.textToObjects("Make me a cube with side_length 17");
    allObjects.forEach((element) {
      print(element.toStringDisplay());
    });
    print(allObjects[0].getProperty('side_length'));
  }
}
