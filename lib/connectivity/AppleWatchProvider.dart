import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppleWatchProvider {
  AppleWatchProvider () {
    if(defaultTargetPlatform == TargetPlatform.iOS) {
      // register callback handler
      //_logCallbacks();
    }
  }

  // channel name in flutter side needs to match AppDelegate at ios side
  static const _channelName = 'com.nikkijuk.bmi.watch';

  final _channel = const MethodChannel(_channelName);

  Future<void> sendBmiToWatch(double value) async {

    // check tha we are on proper platform
    if(defaultTargetPlatform == TargetPlatform.iOS) {

      // method name which is implemented at native side
      const method = 'flutterToWatch';

      // well, these we try to pass to watch
      final arguments = {'method': 'sendBmiToWatch', 'data': value.toString()};
      try {
        // call is async
        // we could save future that is returned and check returned value if needed
        await _channel.invokeMethod(method, arguments);
        debugPrint ('succeeded to call: $method');
      } on PlatformException catch (e) {
        // catch error at native side
        // The type of error coming from native is always [PlatformException]
        debugPrint ('failed to call: $method');
      }
    } else {
      debugPrint ('failed to call: NOT IOS???');
    }
  }


  // return channel not implemented
  /*
  Future<void> _logCallbacks() async {
    _channel.setMethodCallHandler((call) async {
      // Receive data from Native
      switch (call.method) {
        case "watchToFlutter":
          debugPrint ("native -> called watchToFlutter, value '${call.arguments.toString()}'");
          break;
        default:
          debugPrint ("native ->called: ${call.method}");
          break;
      }
    });
  }
   */
}
