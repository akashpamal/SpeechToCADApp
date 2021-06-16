import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi {
  static final _speech = SpeechToText();

  static Future<bool> toggleRecording() async {
    final isAvailable = await _speech.initialize();
    if (isAvailable) {
      _speech.listen(onResult: (value) => print('Transcribed text: ' + value.recognizedWords));
    }
    return isAvailable;
  }
}