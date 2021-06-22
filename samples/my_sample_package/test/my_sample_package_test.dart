import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sample_package/my_sample_package.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_sample_package');

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
    expect(await MySamplePackage.platformVersion, '42');
  });
}
