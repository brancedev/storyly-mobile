import Flutter
import UIKit

public class SwiftStorylyFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(FlutterStorylyViewFactory(registrar: registrar), withId: "FlutterStorylyView")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
