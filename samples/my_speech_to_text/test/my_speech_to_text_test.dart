import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_speech_to_text/my_speech_to_text.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_speech_to_text');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MySpeechToText.platformVersion, '42');
  });
}
