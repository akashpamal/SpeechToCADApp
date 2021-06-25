import Cocoa
import FlutterMacOS

public class MySamplePackagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_sample_package", binaryMessenger: registrar.messenger)
    let instance = MySamplePackagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString + "lalala")
    case "myCustomMethod":
        result("This is the result from my custom method")
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
