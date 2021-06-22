import Flutter
import UIKit

public class SwiftMySamplePackagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_sample_package", binaryMessenger: registrar.messenger())
    let instance = SwiftMySamplePackagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformSpecificStringManual":
        print("This is from iOS")
        result(nil)
        break
    case "getPlatformVersion":
        print("This is the other method")
        break
    default:
        result(FlutterMethodNotImplemented)
        break
    }
    //    result("iOS " + UIDevice.current.systemVersion)
  }
}
