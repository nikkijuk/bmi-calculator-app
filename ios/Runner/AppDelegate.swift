import UIKit
import Flutter
import WatchConnectivity

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  // needs to match channel at Flutter side
  // see: AppleWatchProvider class from calling app or search for "_channelName"
  let channelName = "com.nikkijuk.bmi.watch"
  var channel: FlutterMethodChannel?;

  var session: WCSession?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Get the root controller for the Flutter view.
    let controller :  FlutterViewController = window?.rootViewController as! FlutterViewController

     // Initialize the method channel once the Flutter engines is attached
    channel = FlutterMethodChannel(
          name: channelName,
          binaryMessenger: controller.binaryMessenger)

   // Set a method call handler, whenever we invoke a method from Flutter on channel,
   // this handler will be triggered.
    channel?.setMethodCallHandler({ (
          call: FlutterMethodCall,
          result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            guard call.method == "flutterToWatch" else {
                // If the requested method is not as expected, throw.
                result(FlutterMethodNotImplemented)
                return
            }

            // Handle calls to channel if method name matches
            self.sendToWatch(call : call, result: result)
          }
      )

    // wc session is important, but I'm not yet managing to use it
    /*
    if WCSession.isSupported() {
        let watchSession = WCSession.default;
        watchSession.delegate = self;
        watchSession.activate();
    }
    */

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func sendToWatch(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void {

/*

    // send a message to the watch if it's reachable
    if (WCSession.default.isReachable) {
        // this is a meaningless message, but it's enough for our purposes
        let message = ["Message": "Hello"]
        WCSession.default.sendMessage(message, replyHandler: nil)
    }

  let watchSession = WCSession.default
  let methodData = call.arguments as? [String: Any]
  let method = methodData!["method"]
  let data = methodData!["data"]

  let watchData: [String: Any] = ["method": method, "data": data]

  // Pass the receiving message to Apple Watch
  watchSession.sendMessage(watchData, replyHandler: nil, errorHandler: nil)

  print("value sent to watch")

  result(true)


      */
       print("flutter method not implemented")
  }
}

// these are here to allow usage of wc session
// see https://www.hackingwithswift.com/read/37/8/communicating-between-ios-and-watchos-wcsession

extension AppDelegate: WCSessionDelegate {

  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

  }

  func sessionDidBecomeInactive(_ session: WCSession) {

  }

  func sessionDidDeactivate(_ session: WCSession) {

  }

  // I don't have any idea of this code makes sense..
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let method = message["method"] as? String, let controller = self.window?.rootViewController as? FlutterViewController {
                let channel = FlutterMethodChannel(
                    name: "com.nikkijuk.bmi.watch",
                    binaryMessenger: controller.binaryMessenger)

                channel.invokeMethod(method, arguments: message)
            }
        }
    }
}
