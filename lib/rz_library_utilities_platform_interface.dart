import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rz_library_utilities_method_channel.dart';

abstract class RzLibraryUtilitiesPlatform extends PlatformInterface {
  /// Constructs a RzLibraryUtilitiesPlatform.
  RzLibraryUtilitiesPlatform() : super(token: _token);

  static final Object _token = Object();

  static RzLibraryUtilitiesPlatform _instance = MethodChannelRzLibraryUtilities();

  /// The default instance of [RzLibraryUtilitiesPlatform] to use.
  ///
  /// Defaults to [MethodChannelRzLibraryUtilities].
  static RzLibraryUtilitiesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RzLibraryUtilitiesPlatform] when
  /// they register themselves.
  static set instance(RzLibraryUtilitiesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
