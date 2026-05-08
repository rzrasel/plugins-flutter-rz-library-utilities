import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rz_library_utilities_platform_interface.dart';

/// An implementation of [RzLibraryUtilitiesPlatform] that uses method channels.
class MethodChannelRzLibraryUtilities extends RzLibraryUtilitiesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rz_library_utilities');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
