import UIKit
import Flutter
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Initialize App Center
    let configuration = AppCenterConfiguration(appSecret: "4868c949-ca78-46b1-9a8d-21aa6c3b04ad")
    AppCenter.start(with: configuration, services: [
      Crashes.self,
      Analytics.self // Include other services if needed
    ])
    
    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
