
import 'dart:async';

import 'package:flutter/services.dart';

class MySamplePackage {
  static const MethodChannel _channel =
      const MethodChannel('my_sample_package');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> getPlatformSpecificStringManual() async {
    final String? version = await _channel.invokeMethod('getPlatformSpecificStringManual');
    return version!;
  }
}
