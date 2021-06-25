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
      home: HomePageTextBased(),
    );
  }
}

class HomePageButtonBased extends StatelessWidget {
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

class HomePageTextBased extends StatelessWidget {
  final instructionTextFieldController = TextEditingController(text: "make a cube with side length 5");
  final textParser = TextParser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Text in column'),
            TextField(
              controller: instructionTextFieldController,
              decoration: InputDecoration(
                hintText: "Enter a command to execute in Fusion360",
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
              onPressed: () {
                String textToExecute = this.instructionTextFieldController.text;
                List objectList = textParser.textToObjects(textToExecute);
                print('objectList:');
                // print(objectList);
                objectList.forEach((element) {
                  print(element.toString());
                  // com
                });


              },
              child: Text("Execute commands"),
            )
          ],
        ),
      ),
    );
  }
}
